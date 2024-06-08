import 'package:flutter/material.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/base/base.dart';

void showOrderCompletedDialog(BuildContext context,
    {bool barrierDismissible = true}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(
              horizontal: context.appPadding, vertical: context.appPadding2),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Order successfully!', style: AppStyle.bold(20)),
              const SizedBox(height: 16),
              BaseButton(
                title: 'Back to Home',
                onSubmit: () {
                  context.popUntil();
                },
              )
            ],
          ),
        );
      });
}
