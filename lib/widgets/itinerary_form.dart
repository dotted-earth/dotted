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
import 'package:icons_plus/icons_plus.dart';

const formControl = SizedBox(height: 24);

class ItineraryForm extends StatefulWidget {
  const ItineraryForm({super.key, required this.destination});

  final WorldCity destination;

  @override
  State<ItineraryForm> createState() => _ItineraryFormState();
}

class _ItineraryFormState extends State<ItineraryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _destinationController;
  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkOutController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  String _accommodation = '';
  int _adults = 1;
  int _children = 0;
  List<DateTime?> _dates = [];

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
    _checkInController.dispose();
    _checkOutController.dispose();
    _budgetController.dispose();
  }

  Future<void> _onGenerate() async {
    if (_dates.isEmpty) return;
    if (_checkInController.text.isEmpty) return;
    if (_checkOutController.text.isEmpty) return;
    if (_accommodation.isEmpty) return;

    int lengthOfStay =
        _dates.length == 1 ? 1 : _dates[1]!.difference(_dates[0]!).inDays + 1;

    final itinerary = ItineraryModel(
        userId: supabase.auth.currentUser!.id,
        startDate: _dates[0]!,
        endDate: _dates.length == 1 ? _dates[0]! : _dates[1]!,
        lengthOfStay: lengthOfStay,
        destination:
            "${widget.destination.city}, ${widget.destination.country}",
        budget: int.tryParse(_budgetController.text) ?? 0,
        itineraryStatus: ItineraryStatusEnum.ai_pending,
        accommodation: _accommodation);

    ItinerariesRepository repo = ItinerariesRepository(
        ItinerariesProvider(), UnsplashRepository(UnsplashProvider()));
    try {
      final itin = await repo.createItinerary(itinerary);
      if (mounted) {
        Navigator.pop(context, itin);
      }
    } catch (err) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(err.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton.filledTonal(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
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
                            _adults += 1;
                          });
                        },
                        icon: const Icon(Icons.add),
                        splashRadius: 1,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(width: 20, child: Text(_adults.toString())),
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: () {
                          if (_adults > 1) {
                            setState(() {
                              _adults -= 1;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove),
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.child_care_outlined,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Children")
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _children += 1;
                          });
                        },
                        icon: const Icon(Icons.add),
                        splashRadius: 1,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(width: 20, child: Text(_children.toString())),
                      const SizedBox(
                        width: 8,
                      ),
                      IconButton(
                        onPressed: () {
                          if (_children > 0) {
                            setState(() {
                              _children -= 1;
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
                value: _dates,
                onValueChanged: (dates) {
                  setState(() {
                    _dates = dates;
                  });
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
                        'X-Goog-Api-Key': Env.googleMapsKey,
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
                                      onSelected(option);
                                      setState(() {
                                        _accommodation = option;
                                      });
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
                  return TextFormField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Your accommodation",
                      prefixIcon: Icon(Icons.hotel),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter where you're staying";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _accommodation = value;
                      });
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _checkInController,
                      onTap: () async {
                        final time = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (time != null) {
                          _checkInController.text = time.format(context);
                        }
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixIcon: const Icon(
                            FontAwesome.clock,
                          ),
                          hintText: "Check-in"),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _checkOutController,
                      onTap: () async {
                        final time = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (time != null) {
                          _checkOutController.text = time.format(context);
                        }
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          prefixIcon: const Icon(
                            FontAwesome.clock,
                          ),
                          hintText: "Check-out"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _budgetController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    prefixIcon: const Icon(
                      Icons.money,
                    ),
                    hintText: "Budget"),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.maxFinite,
                child: FilledButton.icon(
                  onPressed: _onGenerate,
                  label: const Text("Generate"),
                  icon: const Icon(Icons.auto_awesome),
                ),
              )
            ],
          ),
        ));
  }
}
