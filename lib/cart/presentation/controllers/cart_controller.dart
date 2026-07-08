import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/cart/domain/usecase/get_cart_list_usecase.dart';
import 'package:prjgetxproduct/cart/domain/usecase/remove_cart_usecase.dart';
import 'package:prjgetxproduct/product/presentation/controllers/product_controller.dart';

class CartController extends GetxController {
  final cartList = <Cart>[].obs;
  GetCartListUseCase _getCartListUseCase;
  RemoveCartUseCase _removeCartUseCase;
  CartController(this._getCartListUseCase, this._removeCartUseCase);
  @override
  void onInit() {
    super.onInit();
    getCartList();
  }

  void getCartList() {
    final cartListFromLocal = _getCartListUseCase();
    if (cartListFromLocal.isNotEmpty) {
      cartList.assignAll(cartListFromLocal);
    } else {
      cartList.value = [];
    }
  }

  void removeCart(int id) async {
    final productController = Get.find<ProductController>();
    await _removeCartUseCase(id);
    Get.snackbar(
      "Thành công",
      "Sản phẩm đã bị xóa khỏi giỏ hàng",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 10,
    );
    productController.countCartItem();
    getCartList();
  }
}
