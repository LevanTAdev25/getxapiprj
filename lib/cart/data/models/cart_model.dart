import 'package:hive_flutter/hive_flutter.dart';
import 'package:prjgetxproduct/product/data/models/category_model.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String code;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final int stock;
  @HiveField(5)
  final CategoryModel categoryModel;
  @HiveField(6)
  final String description;
  @HiveField(7)
  final String image;
  CartModel(
    this.id,
    this.name,
    this.code,
    this.price,
    this.stock,
    this.categoryModel,
    this.description,
    this.image,
  );
}
