import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prjgetxproduct/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/cart/domain/usecase/decrease_cart_usecase.dart';
import 'package:prjgetxproduct/cart/domain/usecase/get_cart_list_usecase.dart';
import 'package:prjgetxproduct/cart/domain/usecase/increase_cart_usecase.dart';
import 'package:prjgetxproduct/cart/domain/usecase/remove_cart_usecase.dart';
import 'package:prjgetxproduct/product/presentation/controllers/product_controller.dart';

class CartController extends GetxController {
  final cartList = <Cart>[].obs;
  final totalPrice = 0.0.obs;
  final priceFormatter = NumberFormat("#,##0", "vi_VN");
  final GetCartListUseCase _getCartListUseCase;
  final RemoveCartUseCase _removeCartUseCase;
  final DecreaseCartUseCase _decreaseCartUseCase;
  final IncreaseCartUseCase _increaseCartUseCase;
  final productController = Get.find<ProductController>();
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
    productController.countCartItem();
    getCartList();
    calculateTotalPrice();
  }

  void decreaseCart(Cart cart) async {
    await _decreaseCartUseCase(cart);
    productController.countCartItem();
    getCartList();
    calculateTotalPrice();
  }

  void increaseCart(Cart cart) async {
    await _increaseCartUseCase(cart);
    productController.countCartItem();
    getCartList();
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    double currentTotalPrice = 0;
    if (cartList.value.isNotEmpty) {
      for (final i in cartList) {
        currentTotalPrice += i.price * i.quantity;
      }
      totalPrice.value = currentTotalPrice;
    }
  }
}
