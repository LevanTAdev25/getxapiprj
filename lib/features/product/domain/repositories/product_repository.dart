import 'package:prjgetxproduct/base/params/get_pagination_params.dart';
import 'package:prjgetxproduct/features/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/features/product/domain/entities/category.dart';
import 'package:prjgetxproduct/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProductList(GetPaginationParams getPaginationParams);
  Future<void> addProduct(Product newProduct);
  Future<void> removeProduct(int id);
  Future<void> updateProduct(Product product);
  Future<List<Category>> getCategoriesList();
  Future<void> addToCart(Cart cart);
  Future<int> countCartItem();
}
