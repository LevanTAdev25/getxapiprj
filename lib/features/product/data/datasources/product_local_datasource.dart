import 'package:prjgetxproduct/features/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

abstract class ProductLocalDatasource {
  Future<void> addToCart(CartModel cartModel);
  Future<int> countCartItem();
}

class ProductLocalDatasourceImpl extends ProductLocalDatasource {
  final CartService _cartService;
  ProductLocalDatasourceImpl(this._cartService);
  @override
  Future<void> addToCart(CartModel cartModel) async {
    await _cartService.addToListCart(cartModel);
  }

  @override
  Future<int> countCartItem() async {
    final listCartItem = await _cartService.getListCartModel();

    return listCartItem.length;
  }
}
