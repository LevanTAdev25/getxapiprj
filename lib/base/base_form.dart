import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/product/domain/entities/category.dart';
import 'package:prjgetxproduct/product/presentation/controllers/product_controller.dart';

class BaseForm extends GetView<ProductController> {
  bool baseFormState;
  BaseForm({super.key, required this.baseFormState});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            enabled: !baseFormState,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Tên không sản phẩm không được để trống";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller.nameEditingController,
            decoration: InputDecoration(
              label: const Text("Tên sản phẩm"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            enabled: !baseFormState,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Mã sản phẩm không được để trống";
              }
              return null;
            },
            controller: controller.codeEditingController,
            decoration: InputDecoration(
              label: const Text("Mã sản phẩm"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            enabled: !baseFormState,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Giá sản phẩm không được để trống";
              }
              if (double.tryParse(value) == null) {
                return "Nhập đúng định dạng giá tiền";
              }
              if (double.tryParse(value) != null && double.parse(value) < 0) {
                return "Giá tiền không được bé hơn 0";
              }
              return null;
            },
            controller: controller.priceEditingController,
            decoration: InputDecoration(
              label: const Text("Giá sản phẩm"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            enabled: !baseFormState,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Số lượng sản phẩm không được để trống";
              }
              if (double.tryParse(value) == null) {
                return "Nhập đúng định dạng số lượng sản phẩm";
              }
              if (double.tryParse(value) != null && double.parse(value) < 0) {
                return "Số lượng sản phẩm không được bé hơn 0";
              }
              return null;
            },
            controller: controller.stockEditingController,
            decoration: InputDecoration(
              label: const Text("Số lượng sản phẩm"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            enabled: !baseFormState,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Mô tả không được để trống";
              }
              return null;
            },
            controller: controller.descriptionEditingController,
            decoration: InputDecoration(
              label: const Text("Mô tả"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            enabled: !baseFormState,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Link ảnh không được để trống";
              }
              return null;
            },
            controller: controller.imageEditingController,
            decoration: InputDecoration(
              label: const Text("Link ảnh"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Category>(
                  value:
                      controller.selectedCategory.value ??
                      controller.categoriesList.first,
                  isExpanded: true,
                  items: controller.categoriesList.map((category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: baseFormState
                      ? null
                      : (value) {
                          controller.selectedCategory.value = value!;
                        },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
