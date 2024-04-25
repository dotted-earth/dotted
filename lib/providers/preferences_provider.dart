import 'package:supabase_flutter/supabase_flutter.dart';

class PreferencesProvider {
  late SupabaseClient _supabase;

  PreferencesProvider() {
    _initialize();
  }

  void _initialize() async {
    _supabase = Supabase.instance.client;
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getRecreations() {
    return _supabase.from('recreations').select();
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getDiets() {
    return _supabase.from('diets').select();
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getCuisines() {
    return _supabase.from('cuisines').select();
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getFoodAllergies() {
    return _supabase.from('food_allergies').select();
  }
}
