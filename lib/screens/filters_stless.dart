import 'package:flutter/material.dart';
import 'package:meal_app/provider/filter_provider.dart';
import 'package:meal_app/widget/filter_item.dart';

// FOR SOMETHING ELSE - Can use in place of filters by correcting arguments
// according to providers
class FiltersStlessScreen extends StatelessWidget {
  const FiltersStlessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: const Column(
        children: [
          FilterItem(
            title: "Gluten-free",
            subTitle: "Only include gluten-free meals",
            value: Filter.glutenFree,
            // onFilterToggle:  This will be managed from FilterItem by method
            // in filterProvider
          ),
          FilterItem(
            title: "Lactose-free",
            subTitle: "Only include lactose-free meals",
            value: Filter.lactoseFree,
          ),
          FilterItem(
            title: "Vegan",
            subTitle: "Only include Vegan meals",
            value: Filter.vegan,
          ),
          FilterItem(
            title: "Vegetarian",
            subTitle: "Only include Vegeterian meals",
            value: Filter.vegetarian,
          ),
        ],
      ),
    );
  }
}
