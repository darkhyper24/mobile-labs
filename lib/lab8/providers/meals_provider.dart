import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/meals_service.dart';

class MealsProvider extends ChangeNotifier {
  final MealsService _mealsService = MealsService();

  bool _isLoading = false;
  List<Meal> _meals = [];
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  List<Meal> get meals => _meals;
  String get errorMessage => _errorMessage;

  Future<void> searchMeals(String query) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _meals = await _mealsService.searchMeals(query);
    } catch (e) {
      _errorMessage = 'Failed to load meals';
      _meals = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
