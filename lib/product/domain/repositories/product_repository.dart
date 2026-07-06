import 'package:prjgetxproduct/product/domain/entities/category.dart';
import 'package:prjgetxproduct/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductList();
  Future<void> addProduct(Product newProduct);
  Future<void> removeProduct(int id);
  Future<void> updateProduct(Product product);
  Future<List<Category>> getCategoriesList();
}
