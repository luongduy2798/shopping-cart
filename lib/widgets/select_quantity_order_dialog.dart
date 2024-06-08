import 'package:flutter/material.dart';
import 'package:shoppingcart/models/order_model.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/base/base.dart';

void showSelectQuantityDialog(BuildContext context,
    {Function(OrderModel order)? callbackUpdate,
    required OrderModel order,
    bool barrierDismissible = true}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return SelectQuantityDialog(
          order: order,
          callbackUpdate: callbackUpdate,
        );
      });
}

class SelectQuantityDialog extends StatefulWidget {
  final OrderModel order;
  final Function(OrderModel order)? callbackUpdate;

  SelectQuantityDialog({required this.order, this.callbackUpdate});

  @override
  _SelectQuantityDialogState createState() => _SelectQuantityDialogState();
}

class _SelectQuantityDialogState extends State<SelectQuantityDialog> {
  final TextEditingController controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isValid = true;

  @override
  void initState() {
    setState(() {
      controller.text = widget.order.quantity.toString();
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(
          horizontal: context.appPadding, vertical: context.appPadding2),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.order.product?.name ?? '', style: AppStyle.bold(20)),
            SizedBox(height: 16),
            BaseInput(
              controller: controller,
              focusNode: _focusNode,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a quantity';
                }
                int? quantity = int.tryParse(value);
                if (quantity == null) {
                  return 'Invalid number';
                }
                if (quantity > 999) {
                  return 'Quantity cannot exceed 999';
                }
                if (quantity < 1) {
                  return 'Quantity must be greater than 1';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  isValid = _formKey.currentState?.validate() ?? false;
                });
              },
            ),
            const SizedBox(height: 16),
            BaseButton(
                title: 'Submit',
                backgroundColor: ColorName.orange600,
                isDisable: !isValid,
                onSubmit: () {
                  widget.callbackUpdate?.call(widget.order
                      .copyWith(quantity: int.parse(controller.text)));
                  context.pop();
                }),
          ],
        ),
      ),
    );
  }
}
