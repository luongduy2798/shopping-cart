import 'package:injectable/injectable.dart';
import 'package:shoppingcart/data/database_helper.dart';
import 'package:shoppingcart/data/product_dao/i_product_dao.dart';
import 'package:shoppingcart/models/product_model.dart';

@LazySingleton(as: IProductDao)
class ProductDao extends IProductDao {
  @override
  Future<List<ProductModel>> getProducts(
      {int offset = 0, int limit = 20}) async {
    final db = await DatabaseHelper.instant.database;
    final List<Map<String, dynamic>>? maps = await db?.query(
      'products',
      offset: offset,
      limit: limit,
    );
    return List.generate((maps ?? []).length, (i) {
      return ProductModel.fromJson((maps ?? [])[i]);
    });
  }
}
