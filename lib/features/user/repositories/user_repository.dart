import 'package:dotted/features/user/models/preference_item_model.dart';
import 'package:dotted/features/user/providers/user_provider.dart';
import 'package:dotted/features/user/models/cuisine_model.dart';
import 'package:dotted/features/user/models/diet_model.dart';
import 'package:dotted/features/user/models/food_allergy_model.dart';
import 'package:dotted/features/user/models/recreation_model.dart';
import 'package:dotted/features/user/models/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final UserProvider _userProvider;

  UserRepository(
    this._userProvider,
  );

  User? getUser() {
    return _userProvider.getUser();
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

  void setUserRecreation(String userId, PreferenceItemModel preference) async {
    try {
      final p = await _userProvider.setUserRecreationPreference(
          userId, preference.id);

      print(p);
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
}
