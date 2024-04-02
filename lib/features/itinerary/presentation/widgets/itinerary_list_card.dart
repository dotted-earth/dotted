import 'package:dotted/features/itinerary/models/itinerary_model.dart';
import 'package:dotted/features/itinerary/models/itinerary_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItineraryListCard extends StatelessWidget {
  ItineraryListCard({
    super.key,
    required this.itinerary,
    required this.onDelete,
  });
  final ItineraryModel itinerary;
  VoidCallback onDelete;

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
          Text(itinerary.itineraryStatus.name
              .split('_')
              .join(" ")
              .toUpperCase()),
          itinerary.itineraryStatus.index <= ItineraryStatusEnum.draft.index
              ? ElevatedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"))
              : const SizedBox(),
        ],
      ),
    ));
  }
}
