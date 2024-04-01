import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:dotted/database.dart';
import 'package:dotted/features/itinerary/presentation/widgets/itinerary_form.dart';
import 'package:dotted/utils/constants/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DestinationForm extends StatelessWidget {
  const DestinationForm({
    super.key,
    required this.onSelectedIndex,
    required this.onStartDateChange,
    required this.startDate,
    required this.endDate,
    required this.formKey,
    required this.textFieldsValue,
    required this.onLengthOfStayChange,
  });
  final GlobalKey<FormState> formKey;
  final ValueChanged<int> onSelectedIndex;
  final ValueChanged<DateTime> onStartDateChange;
  final ValueChanged<int> onLengthOfStayChange;
  final DateTime startDate;
  final DateTime endDate;
  final Map<String, dynamic> textFieldsValue;

  void _onNext() {
    if (formKey.currentState!.validate()) {
      onSelectedIndex(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RawAutocomplete(
          optionsBuilder: (textEditingValue) async {
            final text = textEditingValue.text;
            if (text.length > 2) {
              return await database.getDestinations(text);
            }
            return List<Destination>.empty();
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
                          final destination =
                              "${option.city}, ${option.country}";

                          return GestureDetector(
                              onTap: () {
                                textFieldsValue.update(
                                    'destination', (_) => option,
                                    ifAbsent: () => option);
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(destination),
                              ));
                        }),
                  ),
                ),
              ),
            );
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            if (textFieldsValue['destination'] is Destination) {
              final Destination destination = textFieldsValue['destination'];
              textEditingController = TextEditingController(
                  text: "${destination.city}, ${destination.country}");
            }

            return TextFormField(
              autofocus: true,
              focusNode: focusNode,
              controller: textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Destination",
              ),
              onChanged: (value) {
                print(value);
                final newDestination = Destination(
                    id: 0,
                    city: value,
                    country: '',
                    lat: 0,
                    lon: 0,
                    iso31661_2: '',
                    iso31661_3: '');
                textFieldsValue.update('destination', (_) => newDestination,
                    ifAbsent: () => newDestination);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a destination";
                }
                return null;
              },
              onFieldSubmitted: (value) {
                print(">>> $value");
              },
            );
          },
        ),
        formControl,
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                final now = DateTime.now();
                BottomPicker.date(
                  pickerTitle: const Text(
                    'Set your Start Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  dateOrder: DatePickerDateOrder.dmy,
                  initialDateTime: startDate,
                  maxDateTime: DateTime(now.year + 3),
                  minDateTime: DateTime(now.year, now.month, now.day),
                  pickerTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  onSubmit: (date) {
                    onStartDateChange(date);
                  },
                  bottomPickerTheme: BottomPickerTheme.plumPlate,
                ).show(context);
              },
              icon: const Icon(Icons.calendar_month),
              label: const Text("Start Date"),
            ),
            Expanded(
              child: Text(
                DateFormat.yMd().format(startDate),
                textAlign: TextAlign.center,
                textHeightBehavior:
                    const TextHeightBehavior(applyHeightToLastDescent: false),
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
        formControl,
        TextFormField(
          keyboardType: const TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Length of Stay",
          ),
          onChanged: (value) {
            textFieldsValue.update('lengthOfStay', (_) => value,
                ifAbsent: () => value);
            onLengthOfStayChange(int.tryParse(value) ?? 0);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter the number of days you're staying";
            }

            final numRegex = RegExp(r'^[1-9]\d*$');
            if (!numRegex.hasMatch(value)) {
              return "Can only be positive integers";
            }

            return null;
          },
          initialValue: textFieldsValue['lengthOfStay'],
        ),
        Text(
          endDate.isAfter(startDate)
              ? "End date: ${DateFormat.yMd().format(endDate)}"
              : "",
          textAlign: TextAlign.center,
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToLastDescent: false,
          ),
          style: const TextStyle(fontSize: 16),
        ),
        formControl,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: _onNext,
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        )
      ],
    );
  }
}
