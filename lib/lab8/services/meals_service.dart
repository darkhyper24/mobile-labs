import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal.dart';

class MealsService {
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1/search.php';

  Future<List<Meal>> searchMeals(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?s=$query'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['meals'] == null) {
          return [];
        }

        return (data['meals'] as List)
            .map((mealJson) => Meal.fromJson(mealJson))
            .toList();
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }
}
