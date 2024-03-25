// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted/features/itinerary/models/itinerary_model.dart';
import 'package:dotted/features/itinerary/provider/itineraries_provider.dart';

class ItinerariesRepository {
  final ItinerariesProvider _itinerariesProvider;

  ItinerariesRepository(ItinerariesProvider upcomingItinerariesProvider)
      : _itinerariesProvider = upcomingItinerariesProvider;

  Future<List<ItineraryModel>> getUpcomingItineraries(String userId) async {
    try {
      final upcomingItinerariesData =
          await _itinerariesProvider.getUpcomingItineraries(userId);

      final upcomingItineraries = upcomingItinerariesData
          .map((data) => ItineraryModel.fromMap(data))
          .toList();

      return upcomingItineraries;
    } catch (err) {
      throw err.toString();
    }
  }
}
