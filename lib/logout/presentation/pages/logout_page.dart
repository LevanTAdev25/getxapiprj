import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/logout/presentation/controllers/logout_controller.dart';

class LogoutPage extends GetView<LogoutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Trang đăng xuất",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(children: [CircleAvatar(child: Icon(Icons.person))]),
      ),
    );
  }
}
