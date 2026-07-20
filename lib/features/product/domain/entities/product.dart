import 'package:prjgetxproduct/features/product/data/models/product_model.dart';
import 'package:prjgetxproduct/features/product/domain/entities/category.dart';

class Product {
  int id;
  String name;
  String code;
  double price;
  int stock;
  Category category;
  String description;
  String image;
  Product(
    this.id,
    this.name,
    this.code,
    this.price,
    this.stock,
    this.category,
    this.description,
    this.image,
  );
  static Product mapToProduct(ProductModel productModel) {
    return Product(
      productModel.id,
      productModel.name,
      productModel.code,
      productModel.price,
      productModel.stock,
      Category.mapToCategory(productModel.categoryModel),
      productModel.description,
      productModel.image,
    );
  }
}
