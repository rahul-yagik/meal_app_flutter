import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widget/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.onToggleFav, required this.availableMeals});

  final void Function(Meal meal) onToggleFav;
  final List<Meal> availableMeals;

  // Navigation to different screen
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeal = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.push(context, route) Same as below
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: filteredMeal,
        onToggleFav: onToggleFav,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryItem(
              category: category,
              onSelect: () {
                _selectCategory(context, category);
              },
            ),
        ]);
  }
}
