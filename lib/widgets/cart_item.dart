import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/blocs/order_bloc/order_bloc.dart';
import 'package:shoppingcart/models/order_model.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/base/base.dart';
import 'package:shoppingcart/widgets/base/motion_button.dart';
import 'package:shoppingcart/widgets/widgets.dart';

class CartItem extends StatefulWidget {
  final OrderModel order;
  final Function(OrderModel? order)? callbackUpdate;
  const CartItem({super.key, required this.order, this.callbackUpdate});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late OrderModel order;
  late OrderBloc orderBloc;

  @override
  void initState() {
    orderBloc = BlocProvider.of<OrderBloc>(context);
    order = widget.order;
    super.initState();
  }

  _onDeleteOrder() {
    if (widget.callbackUpdate != null) {
      widget.callbackUpdate!.call(null);
      return;
    }
    /////////////////
    orderBloc.add(RemoveFromCartEvent(order));
  }

  _updateOrder(OrderModel order) {
    if (widget.callbackUpdate != null) {
      widget.callbackUpdate!.call(order);
      return;
    }
    /////////////
    orderBloc.add(UpdateOrderEvent(order));
  }

  _increase() {
    if (order.quantity == 999) return;
    setState(() {
      order = order.copyWith(quantity: (order.quantity ?? 0) + 1);
    });
    /////////////
    _updateOrder(order);
  }

  _decrease() {
    if (order.quantity == 1) return;
    setState(() {
      order = order.copyWith(quantity: (order.quantity ?? 0) - 1);
    });
    /////////////
    _updateOrder(order);
  }

  _showSelectQuantityDialog() {
    showSelectQuantityDialog(context, order: order,
        callbackUpdate: (OrderModel newOrder) {
      setState(() {
        order = newOrder;
      });
      _updateOrder(order);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.appPadding),
      margin: const EdgeInsets.only(bottom: 10, left: 2, right: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 5,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.15),
          )
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              order.product?.img ?? '',
              fit: BoxFit.cover,
              width: 84,
              height: 84,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 84,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.product?.name ?? '',
                        style: AppStyle.bold(20),
                      ),
                      MotionButton(
                        onTap: _onDeleteOrder,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(width: 1, color: ColorName.gray)),
                          child: const Center(child: Icon(Icons.close)),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildAction(),
                      RichText(
                          text: TextSpan(
                              text: (order.product?.price ?? 0).numberFormat(),
                              style: AppStyle.bold()
                                  .copyWith(color: ColorName.orange600),
                              children: const [
                            TextSpan(
                                text: 'đ',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1,
                                ))
                          ]))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAction() => Container(
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: ColorName.gray)),
        child: Row(
          children: [
            MotionButton(
              onTap: _decrease,
              child: Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: const Icon(Icons.remove)),
            ),
            MotionButton(
              onTap: _showSelectQuantityDialog,
              child: Container(
                  height: 30,
                  width: 50,
                  decoration: const BoxDecoration(
                      border: Border(
                          left: BorderSide(width: 1, color: ColorName.gray),
                          right: BorderSide(width: 1, color: ColorName.gray))),
                  child: Center(
                      child: Text(order.quantity?.toString() ?? '',
                          style: AppStyle.medium()))),
            ),
            MotionButton(
              onTap: _increase,
              child: Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: const Icon(Icons.add)),
            ),
          ],
        ),
      );
}
