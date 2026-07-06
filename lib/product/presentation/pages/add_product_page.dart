import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/base/base_form.dart';
import 'package:prjgetxproduct/product/domain/entities/product.dart';
import 'package:prjgetxproduct/product/presentation/controllers/product_controller.dart';

class AddProductPage extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
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
        title: const Text(
          "Thêm thông tin sản phẩm",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            Form(
              key: controller.addKeyForm,
              child: BaseForm(
                baseFormState: controller.isAddProductLoading.value,
              ),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 50),
                elevation: 5,
                shadowColor: Colors.grey,
                backgroundColor: Colors.black,
              ),
              onPressed: controller.isAddProductLoading.value
                  ? null
                  : () async {
                      if (controller.addKeyForm.currentState!.validate()) {
                        final product = Product(
                          999,
                          controller.nameEditingController.text,
                          controller.codeEditingController.text,
                          double.parse(controller.priceEditingController.text),
                          int.parse(controller.stockEditingController.text),
                          controller.selectedCategory.value!,
                          controller.descriptionEditingController.text,
                          controller.imageEditingController.text,
                        );
                        await controller.addProduct(product);
                        controller.selectedCategory.value = null;
                      }
                    },
              child: const Text(
                "Thêm sản phẩm",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      }),
    );
  }
}
