import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/blocs/order_bloc/order_bloc.dart';
import 'package:shoppingcart/injection/di.dart';
import 'package:shoppingcart/models/order_model.dart';
import 'package:shoppingcart/models/product_model.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/add_to_cart_sheet.dart';
import 'package:shoppingcart/widgets/base/base.dart';
import 'package:uuid/uuid.dart';

class ProductItem extends StatefulWidget {
  final bool isHot;
  final ProductModel product;
  const ProductItem({super.key, this.isHot = false, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late OrderBloc orderBloc;
  late OrderModel _order;
  @override
  void initState() {
    orderBloc = getIt<OrderBloc>();
    super.initState();
  }

  showPopUpAddToCart() {
    _order = OrderModel(
        id: const Uuid().v4(),
        productId: widget.product.id,
        product: widget.product,
        quantity: 1);
    showAddToCartSheet(context, order: _order,
        callbackUpdate: (OrderModel? order) {
      if (order != null) {
        _order = order;
      } else {
        context.pop();
      }
    }, submit: () {
      context.pop();
      orderBloc.add(AddToCartEvent(_order));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
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
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      child: Image.asset(
                        widget.product.img ?? '',
                        fit: BoxFit.cover,
                      )),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name ?? '',
                            style: AppStyle.bold(),
                          ),
                          const SizedBox(height: 6),
                          RichText(
                              text: TextSpan(
                                  text: (widget.product.price ?? 0)
                                      .numberFormat(),
                                  style: AppStyle.regular()
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
                    ),
                    MotionButton(
                      onTap: showPopUpAddToCart,
                      child: Container(
                          padding: EdgeInsets.all(4),
                          child: Assets.icons.icAddToCart.image(width: 24)),
                    )
                  ],
                ),
              )
            ],
          ),
          if (widget.isHot)
            Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(child: Assets.icons.icFire.image(width: 14)),
                ))
        ],
      ),
    );
  }
}
