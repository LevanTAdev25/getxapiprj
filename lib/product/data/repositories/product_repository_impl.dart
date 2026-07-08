import 'package:prjgetxproduct/base/params/get_pagination_params.dart';
import 'package:prjgetxproduct/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/product/data/datasources/product_datasource_src.dart';
import 'package:prjgetxproduct/product/data/models/category_model.dart';
import 'package:prjgetxproduct/product/data/models/product_model.dart';
import 'package:prjgetxproduct/product/domain/entities/category.dart';
import 'package:prjgetxproduct/product/domain/entities/product.dart';
import 'package:prjgetxproduct/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductsRemoteDatasource _productsRemoteDatasource;
  final ProductLocalDatasource _productLocalDatasource;
  ProductRepositoryImpl(
    this._productsRemoteDatasource,
    this._productLocalDatasource,
  );
  @override
  Future<void> addProduct(Product newProduct) async {
    final newProductModel = ProductModel.mapToProductModel(newProduct);
    await _productsRemoteDatasource.addProductModel(newProductModel);
  }

  @override
  Future<List<Product>> getProductList(
    GetPaginationParams getPaginationParams,
  ) async {
    final List<ProductModel> productListModel = await _productsRemoteDatasource
        .getProductModelList(getPaginationParams);
    final List<Product> productList = productListModel
        .map((productModel) => Product.mapToProduct(productModel))
        .toList();
    return productList;
  }

  @override
  Future<void> removeProduct(int id) async {
    await _productsRemoteDatasource.removeProductModel(id);
  }

  @override
  Future<void> updateProduct(Product product) async {
    final updateProductModel = ProductModel.mapToProductModel(product);
    await _productsRemoteDatasource.updateProductModel(updateProductModel);
  }

  @override
  Future<List<Category>> getCategoriesList() async {
    final List<CategoryModel> listCategoryModel =
        await _productsRemoteDatasource.getCategoriesList();
    final List<Category> listCategory = listCategoryModel
        .map((categoryModel) => Category.mapToCategory(categoryModel))
        .toList();
    return listCategory;
  }

  @override
  Future<void> addToCart(Cart cart) async {
    final cartModel = CartModel.mapToCartModel(cart);
    await _productLocalDatasource.addToCart(cartModel);
  }

  @override
  Future<int> countCartItem() {
    return _productLocalDatasource.countCartItem();
  }
}
