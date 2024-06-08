import 'package:dotted/models/itinerary_model.dart';
import 'package:dotted/models/itinerary_status_enum.dart';
import 'package:dotted/utils/constants/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItinerariesProvider {
  late SupabaseClient _supabase;

  ItinerariesProvider() {
    _initialize();
  }

  void _initialize() async {
    _supabase = supabase;
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getUpcomingItineraries(
      String userId) {
    return _supabase
        .from("itineraries")
        .select("*, media(*)")
        .eq("user_id", userId)
        .lt("itinerary_status", ItineraryStatusEnum.canceled.name);
  }

  PostgrestTransformBuilder<Map<String, dynamic>> createItinerary(
      ItineraryModel itinerary) {
    final payload = {
      'user_id': itinerary.userId,
      'start_date': itinerary.startDate.toIso8601String(),
      'end_date': itinerary.endDate.toIso8601String(),
      'length_of_stay': itinerary.lengthOfStay,
      'destination': itinerary.destination,
      'budget': itinerary.budget,
      'itinerary_status': itinerary.itineraryStatus.name,
      'media_id': itinerary.media?.id,
      'accommodation': itinerary.accommodation,
    };

    return _supabase
        .from("itineraries")
        .insert(payload)
        .select(
          '*, media(*)',
        )
        .single();
  }

  PostgrestTransformBuilder<Map<String, dynamic>?> getItinerarySchedule(
      int itineraryId) {
    return _supabase
        .from("itineraries")
        .select("*,schedules(*,schedule_items(*))")
        .eq('id', itineraryId)
        .maybeSingle();
  }

  PostgrestFilterBuilder<dynamic> deleteItinerary(int itineraryId) {
    return _supabase.from("itineraries").delete().eq("id", itineraryId);
  }
}
