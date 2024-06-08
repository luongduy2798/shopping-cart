import 'package:shoppingcart/models/models.dart';

class OrderModel {
  String? id;
  String? productId;
  int? quantity;
  ProductModel? product;
  OrderModel({this.id, this.productId, this.product, this.quantity});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }

  OrderModel copyWith({
    String? id,
    String? productId,
    int? quantity,
    ProductModel? product,
  }) {
    return OrderModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }
}
