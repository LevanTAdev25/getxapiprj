import 'package:prjgetxproduct/features/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/features/product/presentation/controllers/product_controller.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

abstract class CartLocalDatasource {
  List<CartModel> getCartModelList();
  Future<void> removeCart(int id);
  Future<void> increaseCart(CartModel cartModel);
  Future<void> decreaseCart(CartModel cartModel);
}

class CartLocalDatasourceImpl implements CartLocalDatasource {
  final CartService _cartService;
  final ProductController _productController;
  CartLocalDatasourceImpl(this._cartService, this._productController);
  @override
  List<CartModel> getCartModelList() {
    return _cartService.getListCartModel();
  }

  @override
  Future<void> removeCart(int id) async {
    await _cartService.removeCart(id);
    _productController.countCartItem();
  }

  @override
  Future<void> decreaseCart(CartModel cartModel) async {
    await _cartService.decreaseCart(cartModel);
    _productController.countCartItem();
  }

  @override
  Future<void> increaseCart(CartModel cartModel) async {
    await _cartService.increaseCart(cartModel);
    _productController.countCartItem();
  }
}
