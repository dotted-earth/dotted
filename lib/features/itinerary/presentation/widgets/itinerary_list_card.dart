import 'package:dotted/features/itinerary/models/itinerary_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItineraryListCard extends StatelessWidget {
  const ItineraryListCard({
    super.key,
    required this.itinerary,
  });
  final ItineraryModel itinerary;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          itinerary.media?.id != null
              ? Image.network(
                  itinerary.media!.url,
                )
              : const SizedBox(),
          Text(itinerary.destination),
          Text(
            itinerary.lengthOfStay > 1
                ? "${DateFormat.yMd().format(itinerary.startDate)} - ${DateFormat.yMd().format(itinerary.endDate)}"
                : DateFormat.yMd().format(itinerary.startDate),
          ),
          Text("Destination: ${itinerary.destination}"),
          Text(itinerary.startDate.isAfter(DateTime.now())
              ? "Get ready in ${DateFormat.d().format(itinerary.startDate.subtract(Duration(days: DateTime.now().day)))} day!"
              : "")
        ],
      ),
    ));
  }
}
