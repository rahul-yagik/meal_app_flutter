import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/data/dummy_data.dart';

// Provider() is useful when returning static data
final mealProvider = Provider((ref) {
  return dummyMeals;
});
