import 'package:dotted/models/preference_item_model.dart';
import 'package:dotted/providers/user_provider.dart';
import 'package:dotted/models/cuisine_model.dart';
import 'package:dotted/models/diet_model.dart';
import 'package:dotted/models/food_allergy_model.dart';
import 'package:dotted/models/recreation_model.dart';
import 'package:dotted/models/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final UserProvider _userProvider;

  UserRepository(
    this._userProvider,
  );

  User? getUser() {
    return _userProvider.getUser();
  }

  Future<UserProfileModel> updateUserProfile(
      String userId, UserProfileModel userProfile) async {
    try {
      final data = await _userProvider.updateUserProfile(userId, userProfile);

      return UserProfileModel.fromMap(data);
    } catch (err) {
      throw err.toString();
    }
  }

  Future<UserProfileModel> getUserProfile(String userId) async {
    try {
      final userProfileData = await _userProvider.getUserProfile(userId);
      return UserProfileModel.fromMap(userProfileData!);
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<RecreationModel>> getUserRecreationPreferences(
      String userId) async {
    try {
      final userRecreationsData =
          await _userProvider.getUserRecreationPreferences(userId);
      return userRecreationsData
          .map((data) => RecreationModel.fromMap(data))
          .toList();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<Map<String, dynamic>>> createUserRecreations(
      String userId, List<PreferenceItemModel> preferences) async {
    try {
      final data = await _userProvider.createUserRecreationPreferences(
          userId, preferences);

      return data;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<DietModel>> getUserDietPreferences(String userId) async {
    try {
      final userDietsData = await _userProvider.getUserDietPreferences(userId);

      return userDietsData.map((data) => DietModel.fromMap(data)).toList();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<Map<String, dynamic>>> createUserDiets(
      String userId, List<PreferenceItemModel> preferences) async {
    try {
      final data =
          await _userProvider.createUserDietPreferences(userId, preferences);

      return data;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<CuisineModel>> getUserCuisinePreferences(String userId) async {
    try {
      final userCuisinesData =
          await _userProvider.getUserCuisinePreferences(userId);
      return userCuisinesData
          .map((data) => CuisineModel.fromMap(data))
          .toList();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<Map<String, dynamic>>> createUserCuisines(
      String userId, List<PreferenceItemModel> preferences) async {
    try {
      final data =
          await _userProvider.createUserCuisinePreferences(userId, preferences);

      return data;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<FoodAllergyModel>> getUserFoodAllergies(String userId) async {
    try {
      final userFoodAllergiesData =
          await _userProvider.getUserFoodAllergies(userId);
      return userFoodAllergiesData
          .map((data) => FoodAllergyModel.fromMap(data))
          .toList();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<Map<String, dynamic>>> createUserFoodAllergies(
      String userId, List<PreferenceItemModel> allergies) async {
    try {
      final data =
          await _userProvider.createUserFoodAllergies(userId, allergies);

      return data;
    } catch (err) {
      throw err.toString();
    }
  }
}
