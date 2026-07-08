import 'package:prjgetxproduct/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

abstract class CartLocalDatasource {
  List<CartModel> getCartModelList();
  Future<void> removeCart(int id);
  Future<void> increaseCart(CartModel cartModel);
  Future<void> decreaseCart(CartModel cartModel);
}

class CartLocalDatasourceImpl implements CartLocalDatasource {
  final CartService _cartService;
  CartLocalDatasourceImpl(this._cartService);
  @override
  List<CartModel> getCartModelList() {
    return _cartService.getListCartModel();
  }

  @override
  Future<void> removeCart(int id) async {
    await _cartService.removeCart(id);
  }

  @override
  Future<void> decreaseCart(CartModel cartModel) async {
    await _cartService.decreaseCart(cartModel);
  }

  @override
  Future<void> increaseCart(CartModel cartModel) async {
    await _cartService.addToListCart(cartModel);
  }
}
