import 'package:prjgetxproduct/features/product/data/models/category_model.dart';
import 'package:prjgetxproduct/features/product/domain/entities/product.dart';

class ProductModel {
  final int id;
  final String name;
  final String code;
  final double price;
  final int stock;
  final CategoryModel categoryModel;
  final String description;
  final String image;
  ProductModel(
    this.id,
    this.name,
    this.code,
    this.price,
    this.stock,
    this.categoryModel,
    this.description,
    this.image,
  );
  static ProductModel mapToProductModel(Product product) {
    return ProductModel(
      product.id,
      product.name,
      product.code,
      product.price,
      product.stock,
      CategoryModel.mapToCategoryModel(product.category),
      product.description,
      product.image,
    );
  }

  static ProductModel fromJson(Map<String, dynamic> json) {
    return ProductModel(
      json['id'],
      json['name'],
      json['code'],
      (json['price'] as num).toDouble(),
      json['stock'],
      CategoryModel.fromJson(json['category']),
      json['description'],
      json['image'],
    );
  }

  static Map<String, dynamic> toJson(ProductModel productModel) {
    return {
      'name': productModel.name,
      'code': productModel.code,
      'price': productModel.price,
      'stock': productModel.stock,
      'category_id': productModel.categoryModel.id,
      'description': productModel.description,
      'image': productModel.image,
    };
  }
}
