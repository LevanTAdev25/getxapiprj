import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/auth/domain/entities/auth.dart';
import 'package:prjgetxproduct/auth/presentation/controllers/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
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
                    const Text(
                      "Chào mừng trở lại",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    TextFormField(
                      controller: controller.usernameController,
                      enabled: !controller.isLoading.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tài khoản không được để trống";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Tài khoản",
                        prefixIcon: const Icon(Icons.person_outline),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordController,
                      enabled: !controller.isLoading.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Mật khẩu không được để trống";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        prefixIcon: Icon(Icons.key),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () {
                              if (keyLoginForm.currentState!.validate()) {
                                final authUser = Auth(
                                  controller.usernameController.text,
                                  controller.passwordController.text,
                                );
                                controller.login(authUser);
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
