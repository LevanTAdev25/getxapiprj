import 'package:get/get.dart';
import 'package:prjgetxproduct/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/cart/domain/usecase/get_cart_list_usecase.dart';
import 'package:prjgetxproduct/cart/domain/usecase/remove_cart_usecase.dart';

class CartController extends GetxController {
  final cartList = <Cart>[].obs;
  GetCartListUseCase _getCartListUseCase;
  RemoveCartUseCase _removeCartUseCase;
  CartController(this._getCartListUseCase, this._removeCartUseCase);
  void getCartList() {
    final cartListFromLocal = _getCartListUseCase();
    if (cartListFromLocal.isNotEmpty) {
      cartList.assignAll(cartListFromLocal);
    } else {
      cartList.value = [];
    }
  }

  void removeCart(int id) async {
    await _removeCartUseCase(id);
  }
}
