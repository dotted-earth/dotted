import 'dart:convert';

import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider {
  late SupabaseClient _supabase;

  UserProvider() {
    _initialize();
  }

  void _initialize() async {
    _supabase = Supabase.instance.client;
  }

  User? getUser() {
    return _supabase.auth.currentUser;
  }

  PostgrestTransformBuilder<Map<String, dynamic>?> getUserProfile(
      String userId) {
    return _supabase.from('profiles').select().eq("id", userId).maybeSingle();
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>>
      getUserRecreationPreferences(String userId) {
    return _supabase.from('user_recreations').select().eq("user_id", userId);
  }

  PostgrestFilterBuilder<dynamic> setUserRecreationPreference(
      String userId, int preferenceId) {
    Map<String, dynamic> data = {
      'user_id': userId,
      'recreation_id': preferenceId
    };
    return _supabase.from('user_recreations').upsert(jsonEncode(data));
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getUserDietPreferences(
      String userId) {
    return _supabase.from('user_diets').select().eq("user_id", userId);
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getUserCuisinePreferences(
      String userId) {
    return _supabase.from('user_cuisines').select().eq("user_id", userId);
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getUserFoodAllergies(
      String userId) {
    return _supabase.from('user_food_allergies').select().eq("user_id", userId);
  }
}
