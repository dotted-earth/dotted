import 'package:dotted/features/user/providers/preferences_provider.dart';
import 'package:dotted/features/user/models/cuisine_model.dart';
import 'package:dotted/features/user/models/diet_model.dart';
import 'package:dotted/features/user/models/food_allergy_model.dart';
import 'package:dotted/features/user/models/recreation_model.dart';

class PreferencesRepository {
  final PreferencesProvider _preferencesProvider;

  PreferencesRepository(
    this._preferencesProvider,
  );

  Future<List<RecreationModel>> getRecreations() async {
    try {
      final recreationsData = await _preferencesProvider.getRecreations();

      return recreationsData
          .map((data) => RecreationModel.fromMap(data))
          .toList();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<DietModel>> getDiets() async {
    try {
      final dietsData = await _preferencesProvider.getDiets();
      return dietsData.map((data) => DietModel.fromMap(data)).toList();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<CuisineModel>> getCuisines() async {
    try {
      final cuisinesData = await _preferencesProvider.getCuisines();
      return cuisinesData.map((data) => CuisineModel.fromMap(data)).toList();
    } catch (err) {
      throw err.toString();
    }
  }

  Future<List<FoodAllergyModel>> getFoodAllergies() async {
    try {
      final foodAllergiesData = await _preferencesProvider.getFoodAllergies();
      return foodAllergiesData
          .map((data) => FoodAllergyModel.fromMap(data))
          .toList();
    } catch (err) {
      throw err.toString();
    }
  }
}
