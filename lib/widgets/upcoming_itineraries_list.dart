import 'package:dotted/bloc/itinerary/upcoming_itineraries_bloc.dart';
import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/widgets/itinerary_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingItinerariesList extends StatelessWidget {
  const UpcomingItinerariesList({super.key, required this.upcomingItineraries});

  final List<ItineraryModel> upcomingItineraries;

  final double boxHeight = 340;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: boxHeight,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: upcomingItineraries.length,
          itemBuilder: (context, index) {
            final upcomingItinerary = upcomingItineraries[index];
            return ItineraryListCard(
              itinerary: upcomingItinerary,
              index: index,
              onDelete: () {
                context
                    .read<UpcomingItinerariesBloc>()
                    .add(DeleteItineraryRequested(upcomingItinerary.id!));
              },
            );
          }),
    );
  }
}
