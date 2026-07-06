import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/base/base_unauthorized.dart';
import 'package:prjgetxproduct/base/params/no_params.dart';
import 'package:prjgetxproduct/product/domain/entities/category.dart';
import 'package:prjgetxproduct/product/domain/usecases/get_categories_usecase.dart';
import 'package:prjgetxproduct/exception/unauthorized_exception.dart';
import 'package:prjgetxproduct/product/domain/entities/product.dart';
import 'package:prjgetxproduct/product/domain/usecases/add_product_usecase.dart';
import 'package:prjgetxproduct/product/domain/usecases/get_product_list_usecase.dart';
import 'package:prjgetxproduct/product/domain/usecases/remove_product_usecase.dart';
import 'package:prjgetxproduct/product/domain/usecases/update_product_usecase.dart';

class ProductController extends GetxController {
  GetProductListUseCase _getProductListUseCase;
  AddProductUseCase _addProductUseCase;
  RemoveProductUseCase _removeProductUseCase;
  UpdateProductUseCase _updateProductUseCase;
  GetCategoriesUseCase _getCategoriesUseCase;

  final addKeyForm = GlobalKey<FormState>();
  final updateKeyForm = GlobalKey<FormState>();

  final isLoading = false.obs;
  final isError = false.obs;

  final productList = <Product>[];
  final categoriesList = <Category>[].obs;
  final selectedCategory = Rx<Category?>(null);
  final errorMessage = RxnString();
  final displayedProducts = <Product>[].obs;
  int? idProduct;

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController codeEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController stockEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  final TextEditingController imageEditingController = TextEditingController();
  ProductController(
    this._getProductListUseCase,
    this._addProductUseCase,
    this._removeProductUseCase,
    this._updateProductUseCase,
    this._getCategoriesUseCase,
  );
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadProductList();
    await loadCategoriesList();
    ever(selectedCategory, (selectedCategory) {
      loadProductList();
    });
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    nameEditingController.dispose();
    codeEditingController.dispose();
    priceEditingController.dispose();
    stockEditingController.dispose();
    descriptionEditingController.dispose();
    imageEditingController.dispose();
    super.onClose();
  }

  void updateTextEditingController({Product? currentProduct}) {
    if (currentProduct == null) {
      nameEditingController.text = "";
      codeEditingController.text = "";
      priceEditingController.text = "";
      stockEditingController.text = "";
      descriptionEditingController.text = "";
      imageEditingController.text = "";
    } else {
      idProduct = currentProduct.id;
      nameEditingController.text = currentProduct.name;
      codeEditingController.text = currentProduct.code;
      priceEditingController.text = currentProduct.price.toString();
      stockEditingController.text = currentProduct.stock.toString();
      descriptionEditingController.text = currentProduct.description;
      imageEditingController.text = currentProduct.image;
      selectedCategory.value = currentProduct.category;
    }
  }

  Future<void> loadProductList() async {
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = null;
    try {
      productList.assignAll(await _getProductListUseCase(const NoParams()));
      displayedProducts.value = selectedCategory.value == null
          ? productList
          : productList
                .where(
                  (product) =>
                      product.category.id == selectedCategory.value!.id,
                )
                .toList();
    } on UnauthorizedException {
      BaseUnauthorized.handleUnauthorized();
    } catch (e) {
      print("Error loading products: $e");
      isError.value = true;
      errorMessage.value = "Danh sách sản phẩm trống";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadCategoriesList() async {
    if (isLoading.value) return;
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = null;
    try {
      categoriesList.assignAll(await _getCategoriesUseCase(const NoParams()));
    } on UnauthorizedException {
      BaseUnauthorized.handleUnauthorized();
    } catch (e) {
      print("Error loading categories: $e");
      isError.value = true;
      errorMessage.value = "Danh mục trống";
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProduct() async {
    if (isLoading.value) return;
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = null;
    try {
      final newProduct = Product(
        999,
        nameEditingController.text,
        codeEditingController.text,
        double.parse(priceEditingController.text),
        int.parse(stockEditingController.text),
        selectedCategory.value!,
        descriptionEditingController.text,
        imageEditingController.text,
      );
      final response = await _addProductUseCase(newProduct);
      Get.back();
      Get.snackbar(
        "Thành công",
        "Bạn đã thêm sản phẩm thành công",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      loadProductList();
    } on UnauthorizedException {
      BaseUnauthorized.handleUnauthorized();
    } catch (e) {
      Get.snackbar(
        "Thất bại",
        "Không thể thêm sản phẩm: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.red,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeProduct(int id) async {
    if (isLoading.value) return;
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = null;
    try {
      await _removeProductUseCase(id);
      Get.snackbar(
        "Thành công",
        "Bạn đã xóa sản phẩm thành công",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      loadProductList();
    } on UnauthorizedException {
      BaseUnauthorized.handleUnauthorized();
    } catch (e) {
      Get.snackbar(
        "Thất bại",
        "Không thể xóa sản phẩm: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.red,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct() async {
    if (isLoading.value) return;
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = null;
    try {
      final updateProduct = Product(
        idProduct!,
        nameEditingController.text,
        codeEditingController.text,
        double.parse(priceEditingController.text),
        int.parse(stockEditingController.text),
        selectedCategory.value!,
        descriptionEditingController.text,
        imageEditingController.text,
      );
      await _updateProductUseCase(updateProduct);
      Get.back();
      Get.snackbar(
        "Thành công",
        "Bạn đã cập nhật sản phẩm thành công",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      loadProductList();
    } on UnauthorizedException {
      BaseUnauthorized.handleUnauthorized();
    } catch (e) {
      Get.snackbar(
        "Thất bại",
        "Không thể thêm sản phẩm: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.red,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
