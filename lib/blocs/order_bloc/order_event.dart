part of 'order_bloc.dart';

abstract class OrderEvent {}

class GetListOrderEvent extends OrderEvent {
  GetListOrderEvent();
}

class AddToCartEvent extends OrderEvent {
  AddToCartEvent(this.order);
  OrderModel order;
}

class UpdateOrderEvent extends OrderEvent {
  UpdateOrderEvent(this.order);
  OrderModel order;
}

class RemoveFromCartEvent extends OrderEvent {
  RemoveFromCartEvent(this.order);
  OrderModel order;
}

class RemoveCartEvent extends OrderEvent {
  RemoveCartEvent();
}
