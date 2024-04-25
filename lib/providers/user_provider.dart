import 'package:dotted/models/preference_item_model.dart';
import 'package:dotted/models/user_profile_model.dart';
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

  PostgrestTransformBuilder<Map<String, dynamic>> updateUserProfile(
      String userId, UserProfileModel userProfile) {
    return _supabase
        .from("profiles")
        .update(userProfile.toMap())
        .eq("id", userId)
        .select()
        .single();
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>>
      getUserRecreationPreferences(String userId) {
    return _supabase.from('user_recreations').select().eq("user_id", userId);
  }

  PostgrestTransformBuilder<List<Map<String, dynamic>>>
      createUserRecreationPreferences(
          String userId, List<PreferenceItemModel> preferences) {
    final data = preferences
        .map((preference) =>
            ({'user_id': userId, 'recreation_id': preference.id}))
        .toList();

    return _supabase.from('user_recreations').insert(data).select();
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getUserDietPreferences(
      String userId) {
    return _supabase.from('user_diets').select().eq("user_id", userId);
  }

  PostgrestTransformBuilder<List<Map<String, dynamic>>>
      createUserDietPreferences(
          String userId, List<PreferenceItemModel> preferences) {
    final data = preferences
        .map((preference) => ({'user_id': userId, 'diet_id': preference.id}))
        .toList();

    return _supabase.from('user_diets').insert(data).select();
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getUserCuisinePreferences(
      String userId) {
    return _supabase.from('user_cuisines').select().eq("user_id", userId);
  }

  PostgrestTransformBuilder<List<Map<String, dynamic>>>
      createUserCuisinePreferences(
          String userId, List<PreferenceItemModel> preferences) {
    final data = preferences
        .map((preference) => ({'user_id': userId, 'cuisine_id': preference.id}))
        .toList();

    return _supabase.from('user_cuisines').insert(data).select();
  }

  PostgrestFilterBuilder<List<Map<String, dynamic>>> getUserFoodAllergies(
      String userId) {
    return _supabase.from('user_food_allergies').select().eq("user_id", userId);
  }

  PostgrestTransformBuilder<List<Map<String, dynamic>>> createUserFoodAllergies(
      String userId, List<PreferenceItemModel> preferences) {
    final data = preferences
        .map((preference) =>
            ({'user_id': userId, 'food_allergy_id': preference.id}))
        .toList();

    return _supabase.from('user_food_allergies').insert(data).select();
  }
}
