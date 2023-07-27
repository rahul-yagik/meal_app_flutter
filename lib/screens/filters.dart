import 'package:flutter/material.dart';
import 'package:meal_app/widget/filter_item.dart';

enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _veganFilterSet = false;
  bool _vegeterianFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
    _vegeterianFilterSet = widget.currentFilters[Filter.vegetarian]!;
  }

  void _filterToggle(bool isChecked, String title) {
    if (title == 'Gluten-free') {
      setState(() {
        _glutenFreeFilterSet = isChecked;
      });
    } else if (title == 'Lactose-free') {
      setState(() {
        _lactoseFreeFilterSet = isChecked;
      });
    } else if (title == 'Vegan') {
      setState(() {
        _veganFilterSet = isChecked;
      });
    } else {
      setState(() {
        _vegeterianFilterSet = isChecked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      // WillPopScope() is used as a wrapper which fires callback
      // on pressing back button
      // here we are using it for passing filter data to category screen
      body: WillPopScope(
        // onWillPop function will be invoked by flutter
        // when user leaves the screen
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegan: _veganFilterSet,
            Filter.vegetarian: _vegeterianFilterSet
          });
          // if return true, it will pop the screen out of stack
          // returning false bcoz above we already using pop
          // So, as a result we only pop out screen once
          return false;
        },
        child: Column(
          children: [
            FilterItem(
              title: "Gluten-free",
              subTitle: "Only include gluten-free meals",
              value: _glutenFreeFilterSet,
              onFilterToggle: _filterToggle,
            ),
            FilterItem(
              title: "Lactose-free",
              subTitle: "Only include lactose-free meals",
              value: _lactoseFreeFilterSet,
              onFilterToggle: _filterToggle,
            ),
            FilterItem(
              title: "Vegan",
              subTitle: "Only include Vegan meals",
              value: _veganFilterSet,
              onFilterToggle: _filterToggle,
            ),
            FilterItem(
              title: "Vegetarian",
              subTitle: "Only include Vegeterian meals",
              value: _vegeterianFilterSet,
              onFilterToggle: _filterToggle,
            ),
          ],
        ),
      ),
    );
  }
}
