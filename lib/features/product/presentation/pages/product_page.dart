import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/features/product/presentation/controllers/product_controller.dart';
import 'package:prjgetxproduct/routes/page_app.dart';
part 'build_chip_filter_widget.dart';

class ProductPage extends GetView<ProductController> {
  static const Color bgPrimary = Color(0xFF111416);
  static const Color bgCard = Color(0xFF1D2024);
  static const Color accentColor = Color(0xFFE2F9FF);
  static const Color textGray = Color(0xFF9EAFB8);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: bgPrimary,
      appBar: AppBar(
        backgroundColor: bgPrimary,
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
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 22,
          ),
        ),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: AlignmentGeometry.directional(-1, 0),
              child: Text(
                "Thương hiệu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
          SizedBox(
            height: 45,
            child: Obx(() {
              // return Container(
              //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   color: Colors.white,
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<Category?>(
              //       value: controller.selectedCategory.value,
              //       isExpanded: true,
              //       items: [
              //         const DropdownMenuItem<Category?>(
              //           value: null,
              //           child: Text("Tất cả"),
              //         ),
              //         ...controller.categoriesList.map((category) {
              //           return DropdownMenuItem<Category?>(
              //             value: category,
              //             child: Text(category.name),
              //           );
              //         }),
              //       ],
              //       onChanged: (value) {
              //         controller.selectedCategory.value = value;
              //         controller.applyFilter();
              //       },
              //     ),
              //   ),
              // );
              return ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Nút "Tất cả"
                  _buildFilterChip(
                    title: "Tất cả",
                    isSelected: controller.selectedCategory.value == null,
                    onTap: () {
                      controller.selectedCategory.value = null;
                      controller.applyFilter();
                    },
                  ),
                  // Render danh sách các danh mục động từ controller
                  ...controller.categoriesList.map((category) {
                    final isSelected =
                        controller.selectedCategory.value?.id == category.id;
                    return _buildFilterChip(
                      title: category.name,
                      isSelected: isSelected,
                      onTap: () {
                        controller.selectedCategory.value = category;
                        controller.applyFilter();
                      },
                    );
                  }),
                ],
              );
            }),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: accentColor),
                );
              }
              if (controller.isError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                      Text(
                        "${controller.errorMessage.value}",
                        style: TextStyle(
                          color: textGray,
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
                        "Không có sản phẩm nào thuộc danh mục này",
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.62,
                      ),
                      itemCount: controller.displayedProducts.length,
                      itemBuilder: (context, index) {
                        final product = controller.displayedProducts[index];
                        return GestureDetector(
                          onTap: () {
                            controller.intentProduct = product;
                            Get.toNamed(AppPage.DETAIL_PRODUCT);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: bgCard,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(8),
                                      ),
                                      child: Image.network(
                                        product.image,
                                        height: 130,
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                height: 130,
                                                color: Colors.grey[900],
                                                child: const Icon(
                                                  Icons.image_not_supported,
                                                  color: textGray,
                                                ),
                                              );
                                            },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        product.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "${controller.formatter.format(product.price)}đ",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          IconButton(
                                            constraints: const BoxConstraints(),
                                            padding: const EdgeInsets.all(6),
                                            icon: const Icon(
                                              Icons.add_shopping_cart,
                                              color:
                                                  accentColor, // hoặc Colors.white nếu muốn
                                              size: 20,
                                            ),
                                            onPressed: () =>
                                                controller.addToCart(product),
                                          ),
                                          const SizedBox(width: 4),
                                          // Nút Sửa nhanh
                                          IconButton(
                                            constraints: const BoxConstraints(),
                                            padding: const EdgeInsets.all(6),
                                            icon: const Icon(
                                              Icons.edit,
                                              color: textGray,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              controller
                                                  .updateTextEditingController(
                                                    currentProduct: product,
                                                  );
                                              Get.toNamed(
                                                AppPage.FORM_PRODUCT,
                                                arguments: {"isEdit": true},
                                              );
                                            },
                                          ),
                                          // Nút Xóa nhanh
                                          IconButton(
                                            constraints: const BoxConstraints(),
                                            padding: const EdgeInsets.all(6),
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.redAccent,
                                              size: 18,
                                            ),
                                            onPressed: () =>
                                                _showDeleteDialog(product),
                                          ),
                                        ],
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
        backgroundColor: accentColor,
        foregroundColor: Colors.black,
        onPressed: () {
          try {
            controller.selectedCategory.value = controller.categoriesList.first;
            controller.updateTextEditingController();
            Get.toNamed(AppPage.FORM_PRODUCT, arguments: {"isEdit": false});
          } catch (e) {
            Get.snackbar(
              "Lỗi",
              "Không kết nối được tới server",
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
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
                controller.logout();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(dynamic product) {
    Get.dialog(
      AlertDialog(
        backgroundColor: bgCard,
        title: const Text("Xác nhận", style: TextStyle(color: Colors.white)),
        content: const Text(
          "Bạn có muốn xóa sản phẩm này không?",
          style: TextStyle(color: textGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Không", style: TextStyle(color: textGray)),
          ),
          TextButton(
            onPressed: () {
              controller.removeProduct(product.id);
              Get.back();
            },
            child: const Text("Có", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
