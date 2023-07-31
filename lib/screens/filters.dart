import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/provider/filter_provider.dart';
import 'package:meal_app/widget/filter_item.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({super.key});

  @override
  ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _veganFilterSet = false;
  bool _vegeterianFilterSet = false;

  @override
  void initState() {
    super.initState();
    // using read() bcoz initState() will run once
    final activeFilters = ref.read(filterProvider);

    _glutenFreeFilterSet = activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree]!;
    _veganFilterSet = activeFilters[Filter.vegan]!;
    _vegeterianFilterSet = activeFilters[Filter.vegetarian]!;
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
          ref.read(filterProvider.notifier).setFilters({
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegan: _veganFilterSet,
            Filter.vegetarian: _vegeterianFilterSet
          });
          return true;
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
