import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:dotted/features/itinerary/presentation/widgets/itinerary_form.dart';
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
        TextFormField(
          autofocus: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Destination",
          ),
          onChanged: (value) {
            textFieldsValue.update('destination', (_) => value,
                ifAbsent: () => value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a destination";
            }
            return null;
          },
          initialValue: textFieldsValue['destination'],
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
