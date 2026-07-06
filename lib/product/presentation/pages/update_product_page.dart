import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/base/base_form.dart';
import 'package:prjgetxproduct/product/domain/entities/product.dart';
import 'package:prjgetxproduct/product/presentation/controllers/product_controller.dart';

class UpdateProductPage extends GetView<ProductController> {
  UpdateProductPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Cập nhật sản phẩm",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        return Form(
          key: controller.updateKeyForm,
          child: Column(
            children: [
              BaseForm(baseFormState: controller.isLoading.value),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: Size(300, 50),
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : () async {
                        await controller.updateProduct();
                        controller.selectedCategory.value = null;
                      },
                child: const Text(
                  "Sửa sản phẩm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
