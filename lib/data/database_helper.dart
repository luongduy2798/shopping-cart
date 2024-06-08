import 'dart:math';
import 'package:shoppingcart/models/product_model.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static DatabaseHelper instant = DatabaseHelper._();
  static Database? _database;

  Future<Database?> get database async {
    return _database;
  }

  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    _database = database;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE products(id TEXT PRIMARY KEY, name TEXT, price INTEGER, img TEXT)',
    );

    await db.execute(
      'CREATE TABLE orders(id TEXT PRIMARY KEY, productId TEXT, quantity INTEGER)',
    );

    List<ProductModel> initialProducts = generateProductList();
    for (var product in initialProducts) {
      await db.insert('products', product.toJson());
    }
  }

  List<ProductModel> generateProductList() {
    List<ProductModel> products = List.generate(100, (index) {
      int randomImageIndex = index % Assets.images.values.length;
      Random random = Random();
      int minPrice = 10000;
      int maxPrice = 200000;
      int price =
          minPrice + (random.nextInt((maxPrice - minPrice) ~/ 10000) * 10000);
      return ProductModel(
        id: const Uuid().v4(),
        name: 'Product #${index + 1}',
        price: price,
        img: Assets.images.values.elementAt(randomImageIndex).path,
      );
    });
    return products;
  }
}
