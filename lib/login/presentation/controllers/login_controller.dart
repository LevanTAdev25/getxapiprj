import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/exception/unauthorized_exception.dart';
import 'package:prjgetxproduct/login/domain/entities/login.dart';
import 'package:prjgetxproduct/login/domain/usecases/login_usecase.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final keyLoginForm = GlobalKey<FormState>();
  final loginSuccess = false.obs;
  final isLoading = false.obs;
  LoginController(this._loginUseCase);
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
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  void login() async {
    isLoading(true);
    try {
      final user = Login(usernameController.text, passwordController.text);
      await _loginUseCase(user);
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
}
