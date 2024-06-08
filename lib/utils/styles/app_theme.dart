import 'package:flutter/material.dart';
import 'package:shoppingcart/utils/gen/gen.dart';

class AppThemes {
  ThemeData themData(BuildContext context) {
    return ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
      seedColor: ColorName.orange600,
    )).copyWith(
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: ColorName.dark,
          ),
    );
  }
}
