import 'package:dotted/features/itinerary/bloc/upcoming_itineraries_bloc.dart';
import 'package:dotted/features/itinerary/models/itinerary_model.dart';
import 'package:dotted/features/itinerary/presentation/widgets/itinerary_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingItinerariesList extends StatefulWidget {
  const UpcomingItinerariesList({
    super.key,
  });

  @override
  State<UpcomingItinerariesList> createState() =>
      _UpcomingItinerariesListState();
}

class _UpcomingItinerariesListState extends State<UpcomingItinerariesList> {
  @override
  void initState() {
    super.initState();
    context.read<UpcomingItinerariesBloc>().add(UpcomingItinerariesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpcomingItinerariesBloc, UpcomingItinerariesState>(
      listener: (context, state) {
        if (state is UpcomingItinerariesFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        List<ItineraryModel> upcomingItineraries = [];
        if (state is UpcomingItinerariesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UpcomingItinerariesSuccess) {
          upcomingItineraries = state.upcomingItineraries;
        }

        if (upcomingItineraries.isEmpty) {
          return const Center(
            child: Text("Nothing is here"),
          );
        }

        return ListView.builder(
            itemCount: upcomingItineraries.length,
            itemBuilder: (context, index) {
              final upcomingItinerary = upcomingItineraries[index];
              return ItineraryListCard(itinerary: upcomingItinerary);
            });
      },
    );
  }
}