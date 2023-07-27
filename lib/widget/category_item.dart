import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem(
      {super.key, required this.category, required this.onSelect});

  final Category category;
  final void Function() onSelect;

  @override
  Widget build(BuildContext context) {
    // InkWell and GestureDetector both are used as
    // a event detector. Difference is that InkWell
    // shows visual effect on event.
    return InkWell(
      onTap: () {
        onSelect();
      },

      // color which get on onTap
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),

      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
