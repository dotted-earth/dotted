import 'package:dotted/common/providers/unsplash_provider.dart';
import 'package:dotted/common/repositories/unsplash_repository.dart';
import 'package:dotted/database.dart';
import 'package:dotted/features/itinerary/models/itinerary_model.dart';
import 'package:dotted/features/itinerary/models/itinerary_status_enum.dart';
import 'package:dotted/features/itinerary/presentation/widgets/accommodation_form.dart';
import 'package:dotted/features/itinerary/presentation/widgets/destination_form.dart';
import 'package:dotted/features/itinerary/provider/itineraries_provider.dart';
import 'package:dotted/features/itinerary/repositories/itineraries_repository.dart';
import 'package:dotted/utils/constants/supabase.dart';
import 'package:flutter/material.dart';

const formControl = SizedBox(height: 24);

class ItineraryForm extends StatefulWidget {
  const ItineraryForm({super.key});

  @override
  State<ItineraryForm> createState() => _ItineraryFormState();
}

class _ItineraryFormState extends State<ItineraryForm> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  bool _needAirportTransportation = false;
  int _selectedIndex = 0;
  final Map<String, dynamic> textFieldsValue = {};
  final _formKey = GlobalKey<FormState>();

  int _getLengthOfStay() {
    return int.tryParse(textFieldsValue['lengthOfStay'] ?? '0') ?? 0;
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
        final lengthOfStay = _getLengthOfStay();
        _endDate =
            date.add(Duration(days: lengthOfStay > 0 ? lengthOfStay - 1 : 0));
      });
    }
  }

  void _onLengthOfStayChange(int days) {
    setState(() {
      final lengthOfStay = _getLengthOfStay();
      _endDate = _startDate
          .add(Duration(days: lengthOfStay > 0 ? lengthOfStay - 1 : 0));
    });
  }

  void _onGenerateItinerary() async {
    final lengthOfStay = _getLengthOfStay();

    final Destination destination = textFieldsValue['destination'];

    final itinerary = ItineraryModel(
      userId: supabase.auth.currentUser!.id,
      startDate: _startDate,
      endDate: _endDate,
      lengthOfStay: lengthOfStay,
      destination: "${destination.city}, ${destination.country}",
      budget: int.tryParse(textFieldsValue["budget"]) ?? 0,
      itineraryStatus: ItineraryStatusEnum.ai_pending,
    );

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
    final screens = [
      DestinationForm(
        onSelectedIndex: _onSelectedIndex,
        onStartDateChange: _onStartDateChange,
        onLengthOfStayChange: _onLengthOfStayChange,
        startDate: _startDate,
        endDate: _endDate,
        formKey: _formKey,
        textFieldsValue: textFieldsValue,
      ),
      AccommodationForm(
        onSelectedIndex: _onSelectedIndex,
        needAirportTransportation: _needAirportTransportation,
        onNeedAirportTransportation: _onNeedAirportTransportation,
        onGenerateItinerary: _onGenerateItinerary,
        textFieldsValue: textFieldsValue,
      )
    ];

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: screens[_selectedIndex],
      ),
    );
  }
}
