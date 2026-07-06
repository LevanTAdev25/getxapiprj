import 'package:prjgetxproduct/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

abstract class CartLocalDatasource {
  List<CartModel> getListCart();
  Future<void> removeCart();
}

class CartLocalDatasourceImpl implements CartLocalDatasource {
  final CartService _cartService;
  CartLocalDatasourceImpl(this._cartService);
  @override
  List<CartModel> getListCart() {
    return _cartService.getListCartModel();
  }

  @override
  Future<void> removeCart() {
    // TODO: implement removeCart
    throw UnimplementedError();
  }
}
