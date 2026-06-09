import '../models/product.dart';
import 'database_helper.dart';

class ProductDAO {

  Future<int> insertProduct(Product product) async {
    final db = await DatabaseHelper.db;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final db = await DatabaseHelper.db;
    final List<Map<String, dynamic>> maps = await db.query('products');

    return maps.map((e) => Product.fromMap(e)).toList();
  }

  Future<int> toggleFavorite(int id, bool status) async {
    final db = await DatabaseHelper.db;

    return await db.update(
      'products',
      {'isFavorite': status ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await DatabaseHelper.db;

    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateProduct(Product product) async {
    final db = await DatabaseHelper.db;

    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
}