import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/models/itinerary_status_enum.dart';
import 'package:dotted/screens/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ItineraryListCard extends StatelessWidget {
  const ItineraryListCard({
    super.key,
    required this.itinerary,
    required this.onDelete,
    required this.index,
  });
  final ItineraryModel itinerary;
  final VoidCallback onDelete;
  final int index;

  String getFriendlyStatusName(ItineraryStatusEnum status) {
    switch (status.name) {
      case 'ai_pending':
        return "Generating Itinerary";
      case 'ai_failure':
        return "Generation Failed";
      case "draft":
        return "Itinerary Draft";
      default:
        return 'Unknown Status';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            itinerary.media?.id != null
                ? GestureDetector(
                    onTap: () {
                      if (itinerary.itineraryStatus.index <
                          ItineraryStatusEnum.draft.index) {
                        return;
                      }

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SchedulePage(
                          itinerary: itinerary,
                        );
                      }));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        itinerary.media!.url,
                        width: double.maxFinite,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const SizedBox(
                    width: double.maxFinite,
                    height: 200,
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
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        getFriendlyStatusName(itinerary.itineraryStatus),
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 14),
                      ),
                      const Spacer(),
                      itinerary.itineraryStatus.name == 'ai_failure'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.auto_fix_high),
                                  tooltip: "Retry",
                                ),
                                IconButton(
                                  onPressed: onDelete,
                                  icon: const Icon(Icons.delete),
                                  tooltip: "Delete",
                                ),
                              ],
                            )
                          : itinerary.itineraryStatus.name == 'ai_pending'
                              ? SizedBox(
                                  height: 48,
                                  width: 48,
                                  child: Center(
                                    child: SpinKitChasingDots(
                                      color: Colors.purple.shade200,
                                      size: 24,
                                    ),
                                  ),
                                )
                              : itinerary.itineraryStatus.index <=
                                      ItineraryStatusEnum.draft.index
                                  ? IconButton(
                                      onPressed: onDelete,
                                      icon: const Icon(Icons.delete),
                                      tooltip: "Delete",
                                    )
                                  : const SizedBox.shrink(),
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
