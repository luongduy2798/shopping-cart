import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/blocs/order_bloc/order_bloc.dart';
import 'package:shoppingcart/injection/di.dart';
import 'package:shoppingcart/models/order_model.dart';
import 'package:shoppingcart/utils/extensions/extension_context.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/styles/app_style.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/base/base.dart';
import 'package:shoppingcart/widgets/widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  late OrderBloc orderBloc;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initData() {
    orderBloc = getIt<OrderBloc>();
    orderBloc.add(GetListOrderEvent());
  }

  submitOrder() {
    showOrderCompletedDialog(context);
    orderBloc.add(RemoveCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
        bloc: orderBloc,
        builder: (context, state) {
          return BaseScreen(
              title: 'Cart (${calculateTotalQuantity(state.orders ?? [])})',
              body: Column(
                children: [
                  _buildListOrder(context, state),
                  if ((state.orders ?? []).isNotEmpty)
                    _buildTotalPrice(context, state)
                ],
              ));
        });
  }

  Widget _buildListOrder(BuildContext context, OrderState state) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.appPadding)
            .copyWith(top: context.appPadding),
        child: ListView.builder(
          itemCount: (state.orders ?? []).length,
          itemBuilder: (context, index) {
            return CartItem(
                key: ValueKey((state.orders ?? [])[index].id),
                order: (state.orders ?? [])[index]);
          },
        ),
      ),
    );
  }

  Widget _buildTotalPrice(BuildContext context, OrderState state) => Container(
        padding: EdgeInsets.all(context.appPadding)
            .copyWith(bottom: context.bottomBarHeight / 2 + context.appPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -2),
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black.withOpacity(0.15),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total price',
                  style: AppStyle.medium(16),
                ),
                RichText(
                    text: TextSpan(
                        text: calculateTotalPrice(state.orders ?? [])
                            .numberFormat(),
                        style: AppStyle.medium(16),
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
            const SizedBox(height: 16),
            BaseButton(
              onSubmit: submitOrder,
              title: 'Order',
            )
          ],
        ),
      );

  int calculateTotalPrice(List<OrderModel> orders) {
    int totalPrice = 0;
    for (var item in orders) {
      totalPrice += (item.product?.price ?? 0) * (item.quantity ?? 1);
    }
    return totalPrice;
  }

  int calculateTotalQuantity(List<OrderModel> orders) {
    return orders.fold(0, (total, order) => total + (order.quantity ?? 0));
  }
}
