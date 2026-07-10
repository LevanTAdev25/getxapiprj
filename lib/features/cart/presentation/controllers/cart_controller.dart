import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prjgetxproduct/features/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/features/cart/domain/usecase/cart_usecase_src.dart';
import 'package:prjgetxproduct/features/product/presentation/controllers/product_controller.dart';

class CartController extends GetxController {
  final cartList = <Cart>[].obs;
  final totalPrice = 0.0.obs;
  final priceFormatter = NumberFormat("#,##0", "vi_VN");
  final GetCartListUseCase _getCartListUseCase;
  final RemoveCartUseCase _removeCartUseCase;
  final DecreaseCartUseCase _decreaseCartUseCase;
  final IncreaseCartUseCase _increaseCartUseCase;
  CartController(
    this._getCartListUseCase,
    this._removeCartUseCase,
    this._decreaseCartUseCase,
    this._increaseCartUseCase,
  );
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
    calculateTotalPrice();
  }

  void removeCart(int id) async {
    await _removeCartUseCase(id);
    Get.snackbar(
      "Thành công",
      "Sản phẩm đã bị xóa khỏi giỏ hàng",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      borderRadius: 10,
    );

    getCartList();
  }

  void decreaseCart(Cart cart) async {
    await _decreaseCartUseCase(cart);

    getCartList();
  }

  void increaseCart(Cart cart) async {
    await _increaseCartUseCase(cart);

    getCartList();
  }

  void calculateTotalPrice() {
    double currentTotalPrice = 0;
    if (cartList.isNotEmpty) {
      for (final i in cartList) {
        currentTotalPrice += i.price * i.quantity;
      }
      totalPrice.value = currentTotalPrice;
    }
  }
}
