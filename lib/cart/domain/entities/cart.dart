import 'package:prjgetxproduct/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/product/domain/entities/category.dart';
import 'package:prjgetxproduct/product/domain/entities/product.dart';

class Cart extends Product {
  final int quantity;
  Cart(
    super.id,
    super.name,
    super.code,
    super.price,
    super.stock,
    super.category,
    super.description,
    super.image,
    this.quantity,
  );
  static Cart mapToCart(CartModel cartModel) {
    return Cart(
      cartModel.id,
      cartModel.name,
      cartModel.code,
      cartModel.price,
      cartModel.stock,
      Category(cartModel.categoryModel.id, cartModel.categoryModel.name),
      cartModel.description,
      cartModel.image,
      cartModel.quantity,
    );
  }
}
