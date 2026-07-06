import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/auth/domain/entities/auth.dart';

import 'package:prjgetxproduct/auth/domain/usecases/login_usecase.dart';
import 'package:prjgetxproduct/auth/domain/usecases/logout_usecase.dart';
import 'package:prjgetxproduct/base/params/no_params.dart';
import 'package:prjgetxproduct/exception/unauthorized_exception.dart';

class AuthController extends GetxController {
  LoginUseCase _loginUseCase;
  LogoutUseCase _logoutUseCase;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loginSuccess = false.obs;
  final isLoading = false.obs;
  AuthController({required this._loginUseCase, required this._logoutUseCase});
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    ever(loginSuccess, (loginSuccess) {
      if (loginSuccess) {
        Get.rawSnackbar(
          title: "Dang nhap thanh cong",
          message: "Dang nhap thanh cong",
          backgroundColor: Colors.green,
          borderColor: Colors.white,
        );
        Get.offAndToNamed("/products");
      }
    });
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login(Auth auth) async {
    isLoading(true);
    try {
      await _loginUseCase(auth);

      loginSuccess(true);
    } on UnauthorizedException {
      Get.snackbar(
        "Đăng nhập thất bại",
        "Tài khoản hoặc mật khẩu",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Đăng nhập thất bại",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    await _logoutUseCase(const NoParams());
  }
}
