import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/base/base_form.dart';
import 'package:prjgetxproduct/features/product/presentation/controllers/product_controller.dart';

class FormProductPage extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    final isEditProduct = Get.arguments['isEdit'];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.selectedCategory.value = null;
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        backgroundColor: Colors.black,
        title: isEditProduct
            ? const Text(
                "Sửa thông tin sản phẩm",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 22,
                ),
              )
            : const Text(
                "Thêm thông tin sản phẩm",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 22,
                ),
              ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Column(
            children: [
              Form(
                key: controller.addKeyForm,
                child: BaseForm(baseFormState: controller.isLoading.value),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 50),
                  elevation: 5,
                  shadowColor: Colors.grey,
                  backgroundColor: Colors.black,
                ),
                onPressed: controller.isLoading.value
                    ? null
                    : isEditProduct == false
                    ? () async {
                        if (controller.addKeyForm.currentState!.validate()) {
                          await controller.addProduct();
                        }
                      }
                    : () async {
                        if (controller.addKeyForm.currentState!.validate()) {
                          Get.dialog(
                            AlertDialog(
                              backgroundColor: Colors.white,
                              title: const Text(
                                "Xác nhận sửa",
                                style: TextStyle(color: Colors.black),
                              ),
                              content: const Text(
                                "Bạn có muốn sửa sản phẩm này không",
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    Get.back();
                                    await controller.updateProduct();
                                  },
                                  child: const Text(
                                    "Có",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                TextButton(
                                  child: const Text(
                                    "Không",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      },
                child: isEditProduct == false
                    ? const Text(
                        "Thêm sản phẩm",
                        style: TextStyle(color: Colors.white),
                      )
                    : const Text(
                        "Sửa sản phẩm",
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
