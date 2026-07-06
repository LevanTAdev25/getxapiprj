import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/product/domain/entities/category.dart';
import 'package:prjgetxproduct/product/presentation/controllers/product_controller.dart';
import 'package:prjgetxproduct/routes/page_app.dart';

class ProductPage extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Danh sách sản phẩm",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 5),
            child: Badge(
              label: const Text("3"),
              backgroundColor: Colors.red,
              child: IconButton(
                icon: Icon(Icons.add_shopping_cart, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Category?>(
                  value: controller.selectedCategory.value,
                  isExpanded: true,
                  items: [
                    const DropdownMenuItem<Category?>(
                      value: null,
                      child: Text("Tất cả"),
                    ),
                    ...controller.categoriesList.map((category) {
                      return DropdownMenuItem<Category?>(
                        value: category,
                        child: Text(category.name),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    controller.selectedCategory.value = value;
                  },
                ),
              ),
            );
          }),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.isError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.hourglass_empty, size: 50, color: Colors.grey),
                      Text(
                        "${controller.errorMessage.value}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (controller.displayedProducts.isEmpty) {
                return const Center(
                  child: Text(
                    "Không có sản phẩm nào thuộc danh mục này",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }

              return GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: controller.displayedProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.displayedProducts[index];
                  return Card(
                    child: Column(
                      children: [
                        Image.network(
                          product.image,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset("assets/images/logo.png");
                          },
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          product.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${product.price}đ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.add_shopping_cart),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.updateTextEditingController(
                                    currentProduct: product,
                                  );
                                  Get.toNamed(AppPage.UPDATE_PRODUCT);
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.removeProduct(product.id);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.selectedCategory.value = controller.categoriesList.first;
          controller.updateTextEditingController();
          Get.toNamed(AppPage.ADD_PRODUCT);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
