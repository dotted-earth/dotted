import 'dart:convert';

import 'package:dotted/database.dart';
import 'package:dotted/env/env.dart';
import 'package:dotted/widgets/itinerary_form.dart';
import 'package:dotted/utils/constants/http_client.dart';
import 'package:flutter/material.dart';

class AccommodationForm extends StatelessWidget {
  const AccommodationForm(
      {super.key,
      required this.onSelectedIndex,
      required this.onNeedAirportTransportation,
      required this.needAirportTransportation,
      required this.onGenerateItinerary,
      required this.textFieldsValue});
  final ValueChanged<int> onSelectedIndex;
  final ValueChanged<bool?> onNeedAirportTransportation;
  final bool needAirportTransportation;
  final VoidCallback onGenerateItinerary;
  final Map<String, dynamic> textFieldsValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RawAutocomplete<String>(
          optionsBuilder: (textEditingValue) async {
            final text = textEditingValue.text;
            if (text.length < 3) {
              return List.empty();
            }
            final Destination destination = textFieldsValue['destination'];

            final postBody = {
              'input': text,
              'includedPrimaryTypes': ['lodging'],
              'locationRestriction': {
                "circle": {
                  "center": {
                    "latitude": destination.lat,
                    "longitude": destination.lon,
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
                                textFieldsValue.update(
                                    'accommodation', (_) => option,
                                    ifAbsent: () => option);
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
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            if (textFieldsValue['accommodation'] != null) {
              textEditingController =
                  TextEditingController(text: textFieldsValue['accommodation']);
            }

            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Place you're staying",
              ),
              onChanged: (value) async {
                textFieldsValue.update('accommodation', (_) => value,
                    ifAbsent: () => value);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter where you're staying";
                }
                return null;
              },
            );
          },
        ),
        formControl,
        const Text("Need transport from airport?"),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                horizontalTitleGap: 0,
                title: const Text('No'),
                leading: Radio<bool>(
                  value: false,
                  groupValue: needAirportTransportation,
                  onChanged: onNeedAirportTransportation,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                horizontalTitleGap: 0,
                title: const Text('Yes'),
                leading: Radio<bool>(
                  value: true,
                  groupValue: needAirportTransportation,
                  onChanged: onNeedAirportTransportation,
                ),
              ),
            ),
          ],
        ),
        TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Budget",
            ),
            keyboardType: const TextInputType.numberWithOptions(),
            onChanged: (value) {
              textFieldsValue.update('budget', (_) => value,
                  ifAbsent: () => value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your budget amount";
              }

              final numRegex = RegExp(r'^[1-9]\d*$');
              if (!numRegex.hasMatch(value)) {
                return "Can only be positive integers";
              }

              return null;
            },
            initialValue: textFieldsValue['budget']),
        formControl,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                onSelectedIndex(0);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            ElevatedButton.icon(
              onPressed: onGenerateItinerary,
              icon: const Icon(Icons.auto_awesome),
              label: const Text("Generate"),
            ),
          ],
        ),
      ],
    );
  }
}
