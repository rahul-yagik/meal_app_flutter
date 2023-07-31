import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/models/meal.dart';

// This class is required for using StateNotifierProvider
// class name must be ends with Notifier
// StateNotifier is generic type. So, provide data type
class FavoritesMealNotifier extends StateNotifier<List<Meal>> {
  // create constructor with initializer list
  // pass initial state with super method
  FavoritesMealNotifier() : super([]);

  // With flutter_riverpod you cannot modify state
  // cannot use mutating methods like add() or remove()
  // always have to reassign the state
  bool toggleMealFavoritesStatus(Meal meal) {
    // state is always available the class
    // comparison is allowed not mutation
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

// StateNotifierProvider is generic type
// first type argument will be whatever it is returning and
// second image will be first argument's data type
final favoritesMealProvider =
    StateNotifierProvider<FavoritesMealNotifier, List<Meal>>((ref) {
  return FavoritesMealNotifier();
});
