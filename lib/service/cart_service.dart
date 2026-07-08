import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prjgetxproduct/cart/data/models/cart_model.dart';

class CartService extends GetxService {
  late Box<CartModel> cartBox;
  Future<CartService> init() async {
    cartBox = await Hive.openBox<CartModel>("list_cart");
    return this;
  }

  List<CartModel> getListCartModel() {
    return cartBox.values.toList();
  }

  Future<void> addToListCart(CartModel cartModel) async {
    final current = cartBox.get(cartModel.id);
    if (current == null) {
      await cartBox.put(cartModel.id, cartModel);
    } else {
      if (current.quantity < current.stock) {
        await cartBox.put(
          current.id,
          current.copyWith(quantity: current.quantity + 1),
        );
      }
    }
  }

  Future<void> decreaseCart(CartModel cartModel) async {
    final current = cartBox.get(cartModel.id);
    if (current == null) {
      await cartBox.put(cartModel.id, cartModel);
    } else {
      if (current.quantity == 1) {
        await cartBox.delete(current.id);
      } else {
        await cartBox.put(
          current.id,
          current.copyWith(quantity: current.quantity - 1),
        );
      }
    }
  }

  Future<void> removeCart(int id) async {
    await cartBox.delete(id);
  }

  Future<void> clearCart() async {
    await cartBox.clear();
  }
}
