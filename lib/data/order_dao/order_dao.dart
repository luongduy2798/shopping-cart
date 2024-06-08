import 'package:shoppingcart/data/database_helper.dart';
import 'package:shoppingcart/data/order_dao/i_order_dao.dart';
import 'package:shoppingcart/models/models.dart';
import 'package:shoppingcart/models/order_model.dart';

class OrderDao extends IOrderDao {
  @override
  Future<void> insertOrUpdateOrder(OrderModel order) async {
    final db = await DatabaseHelper.instant.database;

    final List<Map<String, dynamic>>? existingOrders = await db?.query(
      'orders',
      where: 'productId = ?',
      whereArgs: [order.productId],
    );

    if (existingOrders != null && existingOrders.isNotEmpty) {
      final existingOrder = existingOrders.first;
      final newQuantity = existingOrder['quantity'] + order.quantity;

      await db?.update(
        'orders',
        {'quantity': newQuantity > 999 ? 999 : newQuantity},
        where: 'productId = ?',
        whereArgs: [order.productId],
      );
    } else {
      print('order ${order.toJson()}');
      await db?.insert('orders', order.toJson());
    }
  }

  @override
  Future<List<OrderModel>> getAllOrders() async {
    final db = await DatabaseHelper.instant.database;
    final List<Map<String, dynamic>>? orderMaps = await db?.query('orders');
    final List<OrderModel> orders = [];

    if (orderMaps != null) {
      final List<dynamic> productIds =
          orderMaps.map((orderMap) => orderMap['productId']).toList();

      final List<Map<String, dynamic>>? productMaps = await db?.query(
        'products',
        where: 'id IN (${productIds.map((_) => '?').join(',')})',
        whereArgs: productIds,
      );

      final Map<String, ProductModel> productMapById = Map.fromIterable(
        productMaps ?? [],
        key: (product) => product['id'],
        value: (product) => ProductModel.fromJson(product),
      );

      for (var orderMap in orderMaps) {
        final order = OrderModel.fromJson(orderMap);
        final productId = orderMap['productId'];
        order.product = productMapById[productId];
        orders.add(order);
      }
    }

    return orders;
  }

  @override
  Future<OrderModel?> getOrderById(String id) async {
    final db = await DatabaseHelper.instant.database;
    final List<Map<String, dynamic>>? maps = await db?.query(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps != null && maps.isNotEmpty) {
      return OrderModel.fromJson(maps.first);
    }
    return null;
  }

  @override
  Future<void> updateOrder(OrderModel order) async {
    final db = await DatabaseHelper.instant.database;
    await db?.update(
      'orders',
      order.toJson(),
      where: 'id = ?',
      whereArgs: [order.id],
    );
  }

  @override
  Future<void> deleteOrder(String? id) async {
    final db = await DatabaseHelper.instant.database;
    await db?.delete(
      'orders',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteAllOrders() async {
    final db = await DatabaseHelper.instant.database;
    await db?.delete('orders');
  }
}
