import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widget/category_item.dart';

// For playing animations statefulWidget is required
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

// with keyword is used to add mixin i.e, merging one class with another
// Its not oftenly used but its needed for explicit animation
// for single animation you can use SingleTickerProviderStateMixin.
// for multiple animations TickerProviderStateMixin.
class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // late keyword is telling _animationController will have the value as soon as it will be used
  // not when class is created.
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      // here setting vsync to this keyword i.e, entire class which have all the info
      // provided by SingleTickerProviderStateMixin to break the animation.
      // vsync is responsible to control the animation in every frame i.e, 60 frames/second
      // to provide smooth animation
      vsync: this,
      duration: const Duration(milliseconds: 300),
      // lower value of animation
      lowerBound: 0,
      // upper value of animation. It can set to any number
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Navigation to different screen
  void _selectCategory(BuildContext context, Category category) {
    final filteredMeal = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    // Navigator.push(context, route) Same as below
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: filteredMeal,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      // Animation on Padding
      // builder: ((context, child) => Padding(
      //       padding:
      //           EdgeInsets.only(top: 100 - _animationController.value * 100),
      //       child: child,
      //     )),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
      child: GridView(
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
        ],
      ),
    );
  }
}
