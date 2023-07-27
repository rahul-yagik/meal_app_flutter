import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/screens/categories.dart';
import 'package:meal_app/screens/filters.dart';
import 'package:meal_app/screens/meals.dart';
import 'package:meal_app/widget/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favrouiteMeal = [];
  Map<Filter, bool> _selectedFilter = kInitialFilters;

  void _onSelectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _onToggleFavrouiteMeal(Meal meal) {
    final isExist = _favrouiteMeal.contains(meal);

    if (isExist) {
      setState(() {
        _favrouiteMeal.remove(meal);
      });
      _showInfoMessage("Meal removed from the favrouites...");
    } else {
      setState(() {
        _favrouiteMeal.add(meal);
      });
      _showInfoMessage('Meal added in the favrouites...');
    }
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == "filters") {
      // below code is used for replacing screen instead of pushing on the stack
      // Navigator.of(context).pushReplacement()
      final result = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (ctx) => FiltersScreen(
                  currentFilters: _selectedFilter,
                )),
      );

      setState(() {
        _selectedFilter = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
        onToggleFav: _onToggleFavrouiteMeal, availableMeals: availableMeals);
    String activeTitle = "Pick your Category";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          meals: _favrouiteMeal, onToggleFav: _onToggleFavrouiteMeal);
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
