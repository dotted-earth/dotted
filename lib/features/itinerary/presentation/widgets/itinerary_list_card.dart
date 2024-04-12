import 'package:dotted/features/itinerary/models/itinerary_model.dart';
import 'package:dotted/features/itinerary/models/itinerary_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItineraryListCard extends StatelessWidget {
  const ItineraryListCard({
    super.key,
    required this.itinerary,
    required this.onDelete,
  });
  final ItineraryModel itinerary;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itinerary.media?.id != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      itinerary.media!.url,
                      width: double.maxFinite,
                      height: 128,
                      fit: BoxFit.cover,
                    ),
                  )
                : const SizedBox(
                    width: double.maxFinite,
                    height: 128,
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itinerary.destination,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    itinerary.lengthOfStay > 1
                        ? "${DateFormat.yMd().format(itinerary.startDate)} - ${DateFormat.yMd().format(itinerary.endDate)}"
                        : DateFormat.yMd().format(itinerary.startDate),
                    style:
                        const TextStyle(color: Colors.blueAccent, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                          itinerary.itineraryStatus.name
                              .split('_')
                              .join(" ")
                              .toUpperCase(),
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 14)),
                      const Spacer(),
                      itinerary.itineraryStatus.index <=
                              ItineraryStatusEnum.draft.index
                          ? ElevatedButton.icon(
                              onPressed: onDelete,
                              icon: const Icon(Icons.delete),
                              label: const Text("Delete"))
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
