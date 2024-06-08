import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/blocs/order_bloc/order_bloc.dart';
import 'package:shoppingcart/models/order_model.dart';
import 'package:shoppingcart/pages/cart/cart_screen.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/base/motion_button.dart';

class CardHeader extends StatefulWidget {
  const CardHeader({super.key});

  @override
  State<CardHeader> createState() => _CardHeaderState();
}

class _CardHeaderState extends State<CardHeader> {
  late OrderBloc orderBloc;

  @override
  void initState() {
    orderBloc = BlocProvider.of<OrderBloc>(context);
    orderBloc.add(GetListOrderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
        bloc: orderBloc,
        builder: (context, state) {
          return MotionButton(
            onTap: () => context.navigate(const CartScreen()),
            child: Stack(
              children: [
                Container(
                    width: 100,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(context.appPadding),
                    child: const Icon(Icons.shopping_cart,
                        size: 28, color: Colors.white)),
                if ((state.orders ?? []).isNotEmpty)
                  Positioned(
                      bottom: 10,
                      right: 30,
                      child: Container(
                        height: 20,
                        constraints: const BoxConstraints(minWidth: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            color: ColorName.orange800,
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(width: 1, color: Colors.white)),
                        child: Center(
                          child: Text(
                            calculateTotalQuantity((state.orders ?? []))
                                .toString(),
                            style: AppStyle.medium(12)
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ))
              ],
            ),
          );
        });
  }

  int calculateTotalQuantity(List<OrderModel> orders) {
    return orders.fold(0, (total, order) => total + (order.quantity ?? 0));
  }
}
