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
              BaseForm(baseFormState: controller.isUpdateProductLoading.value),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: Size(300, 50),
                ),
                onPressed: controller.isUpdateProductLoading.value
                    ? null
                    : () async {
                        final updateProduct = Product(
                          controller.idProduct!,
                          controller.nameEditingController.text,
                          controller.codeEditingController.text,
                          double.parse(controller.priceEditingController.text),
                          int.parse(controller.stockEditingController.text),
                          controller.selectedCategory.value!,
                          controller.descriptionEditingController.text,
                          controller.imageEditingController.text,
                        );
                        await controller.updateProduct(updateProduct);
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
