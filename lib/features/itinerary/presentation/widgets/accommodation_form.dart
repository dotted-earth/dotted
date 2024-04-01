import 'package:dotted/features/itinerary/presentation/widgets/itinerary_form.dart';
import 'package:dotted/utils/constants/google_places.dart';
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
        TextFormField(
          autofocus: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Place you're staying",
          ),
          onChanged: (value) async {
            textFieldsValue.update('accommodation', (_) => value,
                ifAbsent: () => value);

            if (value.length > 2) {
              final p = await places.findAutocompletePredictions(value,
                  placeTypesFilter: List.from(['lodging']));
              print(p);
            }
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter where you're staying";
            }
            return null;
          },
          initialValue: textFieldsValue['accommodation'],
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
