import 'package:dotted/features/itinerary/models/itinerary_status_enum.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItinerariesProvider {
  late SupabaseClient _supabase;

  ItinerariesProvider() {
    _initialize();
  }

  void _initialize() async {
    _supabase = Supabase.instance.client;
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getUpcomingItineraries(
      String userId) {
    return _supabase
        .from("itineraries")
        .select()
        .eq("user_id", userId)
        .lt('itinerary_status', ItineraryStatusEnum.canceled.name);
  }
}
