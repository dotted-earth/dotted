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
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _lengthOfStayController = TextEditingController();
  final TextEditingController _accommodationController =
      TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  bool _needAirportTransportation = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _lengthOfStayController.addListener(
      () {
        if (_lengthOfStayController.text.isNotEmpty) {
          final lengthOfDays = int.tryParse(_lengthOfStayController.text) ?? 0;
          setState(() {
            _endDate = _startDate.subtract(Duration(days: lengthOfDays));
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _destinationController.dispose();
    _lengthOfStayController.dispose();
    _accommodationController.dispose();
    _budgetController.dispose();

    super.dispose();
  }

  void _onSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNeedAirportTransportation(bool? value) {
    setState(() {
      _needAirportTransportation = value ?? false;
    });
  }

  void _onStartDateChange(dynamic date) {
    if (date is DateTime) {
      setState(() {
        _startDate = date;
        if (_lengthOfStayController.text.isNotEmpty) {
          final lengthOfDays = int.tryParse(_lengthOfStayController.text) ?? 0;
          _endDate = date.subtract(Duration(days: lengthOfDays));
        }
      });
    }
  }

  void _onGenerateItinerary() {
    // TODO - validate form
    // TODO - create itinerary
    // TODO - close bottom sheet if successful
    // TODO - refetch upcoming itineraries
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DestinationForm(
        onSelectedIndex: _onSelectedIndex,
        destinationController: _destinationController,
        lengthOfStayController: _lengthOfStayController,
        onStartDateChange: _onStartDateChange,
      ),
      AccommodationForm(
        onSelectedIndex: _onSelectedIndex,
        accommodationController: _accommodationController,
        budgetController: _budgetController,
        needAirportTransportation: _needAirportTransportation,
        onNeedAirportTransportation: _onNeedAirportTransportation,
        onGenerateItinerary: _onGenerateItinerary,
      )
    ];

    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: screens[_selectedIndex],
      ),
    );
  }
}

class DestinationForm extends StatelessWidget {
  const DestinationForm({
    super.key,
    required this.onSelectedIndex,
    required this.onStartDateChange,
    required this.destinationController,
    required this.lengthOfStayController,
  });
  final ValueChanged<int> onSelectedIndex;
  final ValueChanged<DateTime> onStartDateChange;
  final TextEditingController destinationController;
  final TextEditingController lengthOfStayController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          autofocus: true,
          controller: destinationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Destination",
          ),
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
                onSubmit: (date) {
                  onStartDateChange(date);
                },
                bottomPickerTheme: BottomPickerTheme.plumPlate,
              ).show(context);
            },
            icon: const Icon(Icons.calendar_month),
            label: const Text("Start Date")),
        formControl,
        TextField(
          controller: lengthOfStayController,
          keyboardType: const TextInputType.numberWithOptions(),
          decoration: const InputDecoration(
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

class AccommodationForm extends StatelessWidget {
  const AccommodationForm({
    super.key,
    required this.onSelectedIndex,
    required this.onNeedAirportTransportation,
    required this.needAirportTransportation,
    required this.budgetController,
    required this.accommodationController,
    required this.onGenerateItinerary,
  });
  final ValueChanged<int> onSelectedIndex;
  final ValueChanged<bool?> onNeedAirportTransportation;
  final bool needAirportTransportation;
  final TextEditingController budgetController;
  final TextEditingController accommodationController;
  final VoidCallback onGenerateItinerary;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          autofocus: true,
          controller: accommodationController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Place you're staying",
          ),
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
        TextField(
          controller: budgetController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Budget",
          ),
          keyboardType: const TextInputType.numberWithOptions(),
        ),
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
