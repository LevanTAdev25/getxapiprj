import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/logout/presentation/controllers/logout_controller.dart';
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
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.white),
            );
          },
        ),
        title: const Text(
          "Danh sách sản phẩm",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: EdgeInsetsGeometry.only(right: 5),
            child: Obx(() {
              return Badge(
                label: Text("${controller.countItem}"),
                backgroundColor: Colors.red,
                child: IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    Get.toNamed(AppPage.CART);
                  },
                ),
              );
            }),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          SearchAnchor(
            searchController: controller.searchController,
            builder: (context, searchController) {
              return SearchBar(
                controller: searchController,
                padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                hintText: "Tìm kiếm sản phẩm",
                onChanged: controller.searchProduct,
                leading: Icon(Icons.search),
              );
            },
            suggestionsBuilder: (context, searchController) {
              final keyword = searchController.text.toLowerCase();
              final result = controller.productList.where((product) {
                return product.name.toLowerCase().contains(keyword);
              });
              return result.map((product) {
                return ListTile(
                  title: Text(product.name),
                  onTap: () {
                    searchController.closeView(product.name);
                    controller.searchProduct(product.name);
                  },
                );
              });
            },
          ),
          const SizedBox(height: 12),
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
                    controller.applyFilter();
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.inventory_2_outlined, color: Colors.grey),
                      Text(
                        "Không có sản phẩm nào",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                key: controller.refreshIndicatorKey,
                onRefresh: controller.handleRefresh,
                child: Stack(
                  children: [
                    GridView.builder(
                      controller: controller.scrollController,
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
                        return InkWell(
                          onTap: () {
                            controller.intentProduct = product;
                            Get.toNamed(AppPage.DETAIL_PRODUCT);
                          },
                          child: Card(
                            child: Column(
                              children: [
                                Image.network(
                                  product.image,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/logo.png",
                                    );
                                  },
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  product.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${controller.formatter.format(product.price)}đ",
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
                                        onPressed: () {
                                          controller.addToCart(product);
                                        },
                                        icon: Icon(Icons.add_shopping_cart),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          controller
                                              .updateTextEditingController(
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
                          ),
                        );
                      },
                    ),
                    Obx(() {
                      if (!controller.isLoadingMore.value) {
                        return const SizedBox();
                      }

                      return const Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }),
                  ],
                ),
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
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Row(
                children: [
                  CircleAvatar(child: Icon(Icons.person)),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: const Text("Xin chào cuongpc10"),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text("Đăng xuất"),
              onTap: () {
                final logoutController = Get.find<LogoutController>();
                logoutController.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
