import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const formControl = SizedBox(height: 24);

class ItineraryForm extends StatefulWidget {
  const ItineraryForm({super.key});

  @override
  State<ItineraryForm> createState() => _ItineraryFormState();
}

class _ItineraryFormState extends State<ItineraryForm> {
  var _selectedIndex = 0;
  List<Widget> screens = [];

  void onSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      screens = [
        DestinationForm(onSelectedIndex: onSelectedIndex),
        AccommodationForm(
          onSelectedIndex: onSelectedIndex,
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: screens[_selectedIndex],
      ),
    );
  }
}

class DestinationForm extends StatelessWidget {
  const DestinationForm({super.key, required this.onSelectedIndex});
  final ValueChanged<int> onSelectedIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: "Destination"),
        ),
        formControl,
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
                initialDateTime: now,
                maxDateTime: DateTime(now.year + 3),
                minDateTime: now,
                pickerTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                onSubmit: (index) {
                  print(index);
                },
                bottomPickerTheme: BottomPickerTheme.plumPlate,
              ).show(context);
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text("Start Date")),
        formControl,
        const TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Length of Stay",
            constraints: BoxConstraints(maxWidth: 141),
          ),
        ),
        formControl,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                onSelectedIndex(1);
              },
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        )
      ],
    );
  }
}

enum Airport { yes, no }

enum TravelIntensity { casual, moderate, sprint }

enum ScheduleLength {
  quarterDay,
  halfDay,
  fullDay,
  wholeDay,
}

class AccommodationForm extends StatefulWidget {
  const AccommodationForm({super.key, required this.onSelectedIndex});
  final ValueChanged<int> onSelectedIndex;

  @override
  State<AccommodationForm> createState() => _AccommodationFormState();
}

class _AccommodationFormState extends State<AccommodationForm> {
  Airport? _airport = Airport.no;
  TravelIntensity? _travelIntensity = TravelIntensity.moderate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextField(
          autofocus: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Hotel you're staying with?"),
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
                leading: Radio<Airport>(
                  value: Airport.no,
                  groupValue: _airport,
                  onChanged: (Airport? value) {
                    setState(() {
                      _airport = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                horizontalTitleGap: 0,
                title: const Text('Yes'),
                leading: Radio<Airport>(
                  value: Airport.yes,
                  groupValue: _airport,
                  onChanged: (Airport? value) {
                    setState(() {
                      _airport = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const Text("Intensity"),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                horizontalTitleGap: 0,
                title: const Text('Casual'),
                leading: Radio<TravelIntensity>(
                  value: TravelIntensity.casual,
                  groupValue: _travelIntensity,
                  onChanged: (TravelIntensity? value) {
                    setState(() {
                      _travelIntensity = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                horizontalTitleGap: 0,
                title: const Text('Moderate'),
                leading: Radio<TravelIntensity>(
                  value: TravelIntensity.moderate,
                  groupValue: _travelIntensity,
                  onChanged: (TravelIntensity? value) {
                    setState(() {
                      _travelIntensity = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                horizontalTitleGap: 0,
                title: const Text('Sprint'),
                leading: Radio<TravelIntensity>(
                  value: TravelIntensity.sprint,
                  groupValue: _travelIntensity,
                  onChanged: (TravelIntensity? value) {
                    setState(() {
                      _travelIntensity = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        formControl,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                widget.onSelectedIndex(0);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.auto_awesome),
              label: const Text("Generate"),
            ),
          ],
        ),
      ],
    );
  }
}
