import 'package:prjgetxproduct/cart/domain/entities/cart.dart';

abstract class CartRepository {
  List<Cart> getCartList();
  Future<void> removeCart(int id);
}
