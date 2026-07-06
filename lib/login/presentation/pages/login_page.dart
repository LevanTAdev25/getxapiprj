import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/base/base_login.dart';
import 'package:prjgetxproduct/login/presentation/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final keyLoginForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 0.5,
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo.png",
          height: 50,
          fit: BoxFit.contain,
        ),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Obx(() {
              return Form(
                key: keyLoginForm,
                child: Column(
                  children: [
                    BaseLogin(baseFormState: controller.isLoading.value),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              if (keyLoginForm.currentState!.validate()) {
                                controller.login();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(200, 50),
                        backgroundColor: Colors.black, // Màu chủ đạo của nút
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Bo góc đồng bộ với ô nhập liệu
                        ),
                        elevation: 2,
                      ),
                      child: controller.isLoading.value
                          ? SizedBox(
                              width: 20,
                              height: 25,
                              child: CircularProgressIndicator(),
                            )
                          : Text("Đăng nhập"),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
