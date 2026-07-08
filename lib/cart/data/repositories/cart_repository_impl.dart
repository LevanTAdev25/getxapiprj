import 'package:prjgetxproduct/cart/data/datasources/cart_local_datasource.dart';
import 'package:prjgetxproduct/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl extends CartRepository {
  final CartLocalDatasource _cartLocalDatasource;
  CartRepositoryImpl(this._cartLocalDatasource);
  @override
  Future<void> removeCart(int id) async {
    await _cartLocalDatasource.removeCart(id);
  }

  @override
  List<Cart> getCartList() {
    final listCart = _cartLocalDatasource
        .getCartModelList()
        .map((cartModel) => Cart.mapToCart(cartModel))
        .toList();
    return listCart;
  }

  @override
  Future<void> decreaseCart(Cart cart) async {
    final cartModel = CartModel.mapToCartModel(cart);
    await _cartLocalDatasource.decreaseCart(cartModel);
  }

  @override
  Future<void> increaseCart(Cart cart) async {
    final cartModel = CartModel.mapToCartModel(cart);
    await _cartLocalDatasource.increaseCart(cartModel);
  }
}
