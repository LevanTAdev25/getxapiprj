import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/routes/page_app.dart';
import 'package:prjgetxproduct/service/auth_service.dart';

class BaseUnauthorized {
  static void handleUnauthorized() async {
    final authService = Get.find<AuthService>();
    await authService.clearToken();
    Get.snackbar(
      "Phiên đăng nhập hết hạn",
      "Vui lòng đăng nhập lại",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.orangeAccent.withOpacity(0.9),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
    Get.offAllNamed(AppPage.LOGIN);
  }
}
