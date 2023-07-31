import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/favorites_provider.dart';
import 'package:meal_app/provider/filter_provider.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widget/main_drawer.dart';

// ConsumerStatefulWidget: to consume data from provider
class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

// change state with consumerState
  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedPageIndex = 0;

  void _onSelectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) {
    Navigator.of(context).pop();

    if (identifier == "filters") {
      // below code is used for replacing screen instead of pushing on the stack
      // Navigator.of(context).pushReplacement()
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const FiltersScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Inside consumer we have access to ref which have utility function
    // like watch(), read() etc
    // watch() is used to call build method when their is any changes in data
    // final meals = ref.watch(mealProvider);
    // final activeFilters = ref.watch(filterProvider);

    final availableMeals = ref.watch(filteredMealProvider);

    Widget activePage = CategoriesScreen(availableMeals: availableMeals);
    String activeTitle = "Pick your Category";

    if (_selectedPageIndex == 1) {
      final favroitesMeal = ref.watch(favoritesMealProvider);

      activePage = MealsScreen(
        meals: favroitesMeal,
      );
      activeTitle = "Your Favrouites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onSelectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dining_rounded), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favrouites'),
        ],
      ),
    );
  }
}
