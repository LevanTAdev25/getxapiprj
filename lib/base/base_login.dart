import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/login/presentation/controllers/login_controller.dart';

class BaseLogin extends GetView<LoginController> {
  final bool baseFormState;
  BaseLogin({super.key, required this.baseFormState});
  @override
  Widget build(BuildContext context) {
    return Column(
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

        SizedBox(height: 8),
        _buildTextField(
          label: "Tài khoản",
          controller: controller.usernameController,
          emptyError: "Tài khoản không được để trống",
          icon: Icon(Icons.person),
          isObscure: false,
        ),
        SizedBox(height: 8),
        _buildTextField(
          label: "Mật khẩu",
          controller: controller.passwordController,
          emptyError: "Mật khẩu không được để trống",
          icon: Icon(Icons.key),
          isObscure: true,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String emptyError,
    required Icon icon,
    required bool isObscure,
  }) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        obscureText: isObscure,
        enabled: !baseFormState,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        validator: (value) {
          if (value == null || value.isEmpty) return emptyError;
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
        ),
      ),
    );
  }
}
