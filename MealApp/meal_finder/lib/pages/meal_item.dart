import 'package:flutter/material.dart';
import 'package:meal_finder/utils/theme.dart';

// ignore: must_be_immutable
class MealItem extends StatelessWidget {
  String name;
  String? description;
  String? calories;

  // ignore: use_key_in_widget_constructors
  MealItem({required this.name, this.calories, this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: ListTile(
        title: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                color: DarkColors.secondary,
              ),
            ),
            calories != null
                ? Text(
                    '$calories cal',
                    style: TextStyle(
                      color: DarkColors.secondary,
                    ),
                  )
                : Text(
                    'N/A cal',
                    style: TextStyle(
                      color: DarkColors.secondary,
                    ),
                  )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        tileColor: DarkColors.accent,
      ),
    );
  }
}
