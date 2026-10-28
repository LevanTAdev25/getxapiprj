import 'package:hive_flutter/hive_flutter.dart';
import 'package:prjgetxproduct/features/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/features/product/data/models/category_model.dart';
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
  @HiveField(8)
  final int quantity;
  CartModel(
    this.id,
    this.name,
    this.code,
    this.price,
    this.stock,
    this.categoryModel,
    this.description,
    this.image,
    this.quantity,
  );
  static CartModel mapToCartModel(Cart cart) {
    return CartModel(
      cart.id,
      cart.name,
      cart.code,
      cart.price,
      cart.stock,
      CategoryModel(cart.category.id, cart.category.name),
      cart.description,
      cart.image,
      1,
    );
  }

  CartModel copyWith({int? quantity}) {
    return CartModel(
      id,
      name,
      code,
      price,
      stock,
      categoryModel,
      description,
      image,
      quantity ?? this.quantity,
    );
  }
}
