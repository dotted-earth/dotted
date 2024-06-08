import 'package:dotted/models/media_modal.dart';
import 'package:dotted/models/schedule.dart';
import 'package:dotted/providers/media_provider.dart';
import 'package:dotted/repositories/unsplash_repository.dart';
import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/providers/itineraries_provider.dart';
import "package:dartz/dartz.dart";

class ItinerariesRepository {
  late ItinerariesProvider _itinerariesProvider;
  late UnsplashRepository _unsplashRepository;

  ItinerariesRepository(ItinerariesProvider upcomingItinerariesProvider,
      UnsplashRepository unsplashRepository)
      : super() {
    _itinerariesProvider = upcomingItinerariesProvider;
    _unsplashRepository = unsplashRepository;
  }

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

  Future<ItineraryModel> createItinerary(ItineraryModel itinerary) async {
    try {
      final imageResponse =
          await _unsplashRepository.getRandomImage(itinerary.destination);
      final MediaProvider mediaProvider = MediaProvider();
      final mediaResponse = await mediaProvider.createMedia(imageResponse);

      final media = MedialModel.fromMap(mediaResponse);
      itinerary.media = media;
      final data = await _itinerariesProvider.createItinerary(itinerary);

      return ItineraryModel.fromMap(data);
    } catch (err) {
      throw err.toString();
    }
  }

  Future<Null> deleteItinerary(int itineraryId) async {
    try {
      final data = await _itinerariesProvider.deleteItinerary(itineraryId);
      return data;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<Either<String, Schedule>> getItinerarySchedule(int itineraryId) async {
    try {
      final data = await _itinerariesProvider.getItinerarySchedule(itineraryId);
      if (data == null) {
        return Left("There is an error: no data");
      }

      final List<Schedule> schedules = (data['schedules'] as List<dynamic>)
          .map((schedule) => Schedule.fromMap(schedule))
          .toList();

      return Right(schedules[0]);
    } catch (e) {
      return Left("There is an error: $e");
    }
  }
}
