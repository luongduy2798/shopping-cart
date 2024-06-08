import 'package:shoppingcart/models/product_model.dart';

abstract class IProductDao {
  Future<List<ProductModel>> getProducts({int offset = 0, int limit = 20});
}
