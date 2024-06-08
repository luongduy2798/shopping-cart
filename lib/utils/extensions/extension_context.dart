import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  navigate<T>(Widget screen,
      {bool pushAndRemoveUntil = false,
      bool isAnimated = false,
      bool rootNavigator = false}) {
    Route<T> route;

    if (isAnimated) {
      route = _createRouteAnimated(screen);
    } else {
      route = MaterialPageRoute<T>(builder: (BuildContext context) => screen);
    }

    if (pushAndRemoveUntil) {
      return Navigator.pushAndRemoveUntil(
        this,
        route,
        (route) => false,
      );
    }

    return Navigator.of(this, rootNavigator: rootNavigator).push(route);
  }

  Route<T> _createRouteAnimated<T>(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation animation,
          Animation secondaryAnimation) {
        return screen;
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  void popUntil() {
    Navigator.of(this).popUntil((route) => route.isFirst);
  }

  void pop() {
    if (!!Navigator.of(this).canPop()) Navigator.of(this).pop();
  }

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  double get appPadding => 16;
  double get appPadding2 => 32;
  double get appBarHeight => AppBar().preferredSize.height;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;
}
