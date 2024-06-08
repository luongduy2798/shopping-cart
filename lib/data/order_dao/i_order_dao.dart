import 'package:shoppingcart/models/order_model.dart';

abstract class IOrderDao {
  Future<void> insertOrUpdateOrder(OrderModel order);
  Future<List<OrderModel>> getAllOrders();
  Future<OrderModel?> getOrderById(String id);
  Future<void> updateOrder(OrderModel order);
  Future<void> deleteOrder(String? id);
  Future<void> deleteAllOrders();
}
