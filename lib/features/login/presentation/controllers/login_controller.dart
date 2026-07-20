import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/exception/unauthorized_exception.dart';
import 'package:prjgetxproduct/features/login/domain/entities/login.dart';
import 'package:prjgetxproduct/features/login/domain/usecases/login_usecase.dart';
import 'package:prjgetxproduct/routes/page_app.dart';

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
      if (loginSuccess.value) {
        Get.rawSnackbar(
          title: "Dang nhap thanh cong",
          message: "Dang nhap thanh cong",
          backgroundColor: Colors.green,
          borderColor: Colors.white,
        );
        Get.offAndToNamed(AppPage.PRODUCTS);
        loginSuccess(false);
      }
    } on UnauthorizedException catch (e) {
      final message = e.toString().replaceAll("Exception: ", "");
      Get.snackbar(
        "Đăng nhập thất bại",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    } catch (e) {
      final message = e.toString().replaceAll("Exception: ", "");
      Get.snackbar(
        "Đăng nhập thất bại",
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }
}
