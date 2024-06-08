import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Material(
            type: MaterialType.transparency,
            child: Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.white,
                size: 50,
              ),
            ));
      });
}
