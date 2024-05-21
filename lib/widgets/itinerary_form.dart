import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dotted/providers/unsplash_provider.dart';
import 'package:dotted/repositories/unsplash_repository.dart';
import 'package:dotted/database.dart';
import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/models/itinerary_status_enum.dart';
import 'package:dotted/utils/constants/env.dart';
import 'package:dotted/utils/constants/http_client.dart';
import 'package:dotted/providers/itineraries_provider.dart';
import 'package:dotted/repositories/itineraries_repository.dart';
import 'package:dotted/utils/constants/supabase.dart';
import 'package:flutter/material.dart';

const formControl = SizedBox(height: 24);

class ItineraryForm extends StatefulWidget {
  const ItineraryForm({super.key, required this.destination});

  final Destination destination;

  @override
  State<ItineraryForm> createState() => _ItineraryFormState();
}

class _ItineraryFormState extends State<ItineraryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _destinationController;
  late DateTime _startDate;
  late DateTime _endDate;
  int _travelers = 1;

  @override
  void initState() {
    super.initState();
    _destinationController = TextEditingController(
        text: '${widget.destination.city}, ${widget.destination.country}');
  }

  @override
  void dispose() {
    super.dispose();
    _destinationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.maxFinite,
          height: 800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _destinationController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  prefixIcon: const Icon(
                    Icons.map_outlined,
                  ),
                  enabled: false,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.luggage_outlined,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Travelers")
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _travelers += 1;
                          });
                        },
                        icon: const Icon(Icons.add),
                        splashRadius: 1,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(width: 20, child: Text(_travelers.toString())),
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: () {
                          if (_travelers > 1) {
                            setState(() {
                              _travelers -= 1;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      )
                    ],
                  ),
                ],
              ),
              CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.range,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 2),
                ),
                value: [],
                onValueChanged: (dates) {
                  if (dates.length < 2) return;
                  print(dates);
                },
              ),
              RawAutocomplete<String>(
                optionsBuilder: (textEditingValue) async {
                  final text = textEditingValue.text;
                  if (text.length < 3) {
                    return List.empty();
                  }

                  final postBody = {
                    'input': text,
                    'includedPrimaryTypes': ['lodging'],
                    'locationRestriction': {
                      "circle": {
                        "center": {
                          "latitude": widget.destination.lat,
                          "longitude": widget.destination.lon,
                        },
                        "radius": 10000.00, // 10km
                      }
                    }
                  };

                  final res = await httpClient.post(
                      Uri.parse(
                          'https://places.googleapis.com/v1/places:autocomplete'),
                      headers: {
                        'Content-Type': "application/json",
                        'X-Goog-Api-Key': Env.googlePlacesKey,
                      },
                      body: jsonEncode(postBody));

                  final data = jsonDecode(res.body);
                  final places = data['suggestions']?.map((suggestion) {
                        return suggestion["placePrediction"]['structuredFormat']
                            ['mainText']["text"];
                      }) ??
                      [];

                  return List.from(places.toList());
                },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Material(
                        elevation: 4.0,
                        child: SizedBox(
                          height: 200,
                          width: 300,
                          child: ListView.builder(
                              padding: const EdgeInsets.all(8),
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final option = options.elementAt(index);

                                return GestureDetector(
                                    onTap: () {
                                      // textFieldsValue.update(
                                      //     'accommodation', (_) => option,
                                      //     ifAbsent: () => option);
                                      onSelected(option);
                                    },
                                    child: ListTile(
                                      title: Text(option),
                                    ));
                              }),
                        ),
                      ),
                    ),
                  );
                },
                fieldViewBuilder: (context, textEditingController, focusNode,
                    onFieldSubmitted) {
                  // if (textFieldsValue['accommodation'] != null) {
                  //   textEditingController =
                  //       TextEditingController(text: textFieldsValue['accommodation']);
                  // }

                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Your accommodation",
                      prefixIcon: Icon(Icons.hotel),
                    ),
                    // onChanged: (value) async {
                    //   textFieldsValue.update('accommodation', (_) => value,
                    //       ifAbsent: () => value);
                    // },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter where you're staying";
                      }
                      return null;
                    },
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixIcon: const Icon(
                            Icons.start_outlined,
                          ),
                          hintText: "Start time"),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixIcon: const Icon(
                            Icons.timer,
                          ),
                          hintText: "End time"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    prefixIcon: const Icon(
                      Icons.money,
                    ),
                    hintText: "Budget"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton.filled(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
