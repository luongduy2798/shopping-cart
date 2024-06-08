import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/data/order_dao/i_order_dao.dart';
import 'package:shoppingcart/data/order_dao/order_dao.dart';
import 'package:shoppingcart/models/order_model.dart';
part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderState()) {
    on<GetListOrderEvent>(_mapGetListChangedToState);
    on<AddToCartEvent>(_mapAddToCartChangedToState);
    on<UpdateOrderEvent>(_mapUpdateOrderChangedToState);
    on<RemoveFromCartEvent>(_mapRemoveFromCartChangedToState);
    on<RemoveCartEvent>(_mapRemoveCartChangedToState);
  }
  IOrderDao orderDao = OrderDao();

  FutureOr<void> _mapGetListChangedToState(
      GetListOrderEvent event, emit) async {
    final List<OrderModel> results = await orderDao.getAllOrders();
    emit(OrderState(orders: results));
  }

  FutureOr<void> _mapAddToCartChangedToState(AddToCartEvent event, emit) async {
    await orderDao.insertOrUpdateOrder(event.order);
    final List<OrderModel> results = await orderDao.getAllOrders();
    emit(OrderState(orders: results));
  }

  FutureOr<void> _mapUpdateOrderChangedToState(
      UpdateOrderEvent event, emit) async {
    await orderDao.updateOrder(event.order);
    final List<OrderModel> results = await orderDao.getAllOrders();
    emit(OrderState(orders: results));
  }

  FutureOr<void> _mapRemoveFromCartChangedToState(
      RemoveFromCartEvent event, emit) async {
    await orderDao.deleteOrder(event.order.id);
    final List<OrderModel> results = await orderDao.getAllOrders();
    emit(OrderState(orders: results));
  }

  FutureOr<void> _mapRemoveCartChangedToState(
      RemoveCartEvent event, emit) async {
    await orderDao.deleteAllOrders();
    emit(OrderState(orders: []));
  }
}
