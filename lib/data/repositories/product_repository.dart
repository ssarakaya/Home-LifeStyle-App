import '../local/product_dao.dart';
import '../models/product.dart';

class ProductRepository {
  // The layered architecture requirement enables access via DAO.
  final ProductDAO _productDAO = ProductDAO();

  Future<List<Product>> fetchProducts() async {
    //We retrieve data by calling the DAO instead of directly calling DatabaseHelper.
    return await _productDAO.getAllProducts();
  }

  Future<void> addProduct(Product product) async {
    await _productDAO.insertProduct(product);
  }

  Future<void> removeProduct(int id) async {
    await _productDAO.deleteProduct(id);
  }

  Future<void> updateFavorite(int id, bool value) async {
    await _productDAO.toggleFavorite(id, value);
  }

  Future<void> updateProduct(Product product) async {
    // For the 'Update' part of the CRUD, we trigger the update method in the DAO.
    await _productDAO.updateProduct(product);
  }
}