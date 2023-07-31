import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/meal_provider.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegan: false,
          Filter.vegetarian: false
        });

  void setFilters(Map<Filter, bool> choosenFilter) {
    state = choosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    // mutation is not allowed: state[filter] = active
    state = {...state, filter: isActive};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filteredMealProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final activeFilters = ref.watch(filterProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
