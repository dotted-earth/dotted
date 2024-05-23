import 'package:dotted/bloc/itinerary/upcoming_itineraries_bloc.dart';
import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/widgets/itinerary_list_card.dart';
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
  double boxHeight = 340;
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
          return SizedBox(
            height: boxHeight,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is UpcomingItinerariesSuccess) {
          upcomingItineraries = state.upcomingItineraries;
        }

        if (upcomingItineraries.isEmpty) {
          return SizedBox(
            height: boxHeight,
            child: const Center(
              child: Text("Nothing is here"),
            ),
          );
        }

        return SizedBox(
          height: boxHeight,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: upcomingItineraries.length,
              itemBuilder: (context, index) {
                final upcomingItinerary = upcomingItineraries[index];
                return ItineraryListCard(
                  itinerary: upcomingItinerary,
                  onDelete: () {
                    context
                        .read<UpcomingItinerariesBloc>()
                        .add(DeleteItineraryRequested(upcomingItinerary.id!));
                  },
                );
              }),
        );
      },
    );
  }
}
