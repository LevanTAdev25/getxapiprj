import 'package:prjgetxproduct/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

abstract class CartLocalDatasource {
  List<CartModel> getCartModelList();
  Future<void> removeCart(int id);
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
}
