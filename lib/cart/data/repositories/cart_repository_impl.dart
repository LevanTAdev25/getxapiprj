import 'package:prjgetxproduct/cart/data/datasources/cart_local_datasource.dart';
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
}
