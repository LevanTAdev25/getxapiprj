import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/cart/presentation/controllers/cart_controller.dart';

class CartPage extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Danh sách sản phẩm trong giỏ hàng",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
