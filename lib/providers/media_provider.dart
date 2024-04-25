import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dotted/utils/constants/supabase.dart';

class MediaProvider {
  final SupabaseClient _supabase = supabase;

  PostgrestTransformBuilder<Map<String, dynamic>> createMedia(String url) {
    return _supabase.from("media").insert({"url": url}).select().single();
  }
}
