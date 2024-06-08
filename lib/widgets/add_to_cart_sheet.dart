import 'package:flutter/material.dart';
import 'package:shoppingcart/models/order_model.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/widgets/base/base.dart';
import 'package:shoppingcart/widgets/widgets.dart';

void showAddToCartSheet(BuildContext context,
    {Function? submit,
    Function(OrderModel? order)? callbackUpdate,
    required OrderModel order,
    bool barrierDismissible = true}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: context.appPadding, vertical: context.appPadding2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CartItem(
                order: order,
                callbackUpdate: callbackUpdate,
              ),
              const SizedBox(height: 16),
              BaseButton(
                title: 'Add to cart',
                backgroundColor: ColorName.orange600,
                onSubmit: submit,
              )
            ],
          ),
        );
      });
}
