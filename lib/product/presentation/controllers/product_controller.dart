import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prjgetxproduct/base/base_unauthorized.dart';
import 'package:prjgetxproduct/base/params/get_pagination_params.dart';
import 'package:prjgetxproduct/base/params/no_params.dart';
import 'package:prjgetxproduct/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/product/domain/entities/category.dart';
import 'package:prjgetxproduct/product/domain/usecases/product_usecase_src.dart';
import 'package:prjgetxproduct/exception/unauthorized_exception.dart';
import 'package:prjgetxproduct/product/domain/entities/product.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

class ProductController extends GetxController {
  final GetProductListUseCase _getProductListUseCase;
  final AddProductUseCase _addProductUseCase;
  final RemoveProductUseCase _removeProductUseCase;
  final UpdateProductUseCase _updateProductUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final CountCartItemUseCase _countCartItemUseCase;
  final addKeyForm = GlobalKey<FormState>();
  final updateKeyForm = GlobalKey<FormState>();
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final isLoading = false.obs;
  final isError = false.obs;

  final productList = <Product>[];
  final categoriesList = <Category>[].obs;
  final selectedCategory = Rx<Category?>(null);
  final errorMessage = RxnString();
  final displayedProducts = <Product>[].obs;
  final countItem = 0.obs;
  final formatter = NumberFormat("#,##0", "vi_VN");
  Product? intentProduct;

  int? idProduct;
  int _page = 1;
  int _limit = 10;
  final isLoadingMore = false.obs;
  bool _hasMore = true;

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController codeEditingController = TextEditingController();
  final TextEditingController priceEditingController = TextEditingController();
  final TextEditingController stockEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  final TextEditingController imageEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final SearchController searchController = SearchController();
  final nameProductFocusNode = FocusNode();
  final codeProductFocusNode = FocusNode();
  final priceProductFocusNode = FocusNode();
  final stockProductFocusNode = FocusNode();
  final descriptionProductFocusNode = FocusNode();
  final imageProductFocusNode = FocusNode();
  ProductController(
    this._getProductListUseCase,
    this._addProductUseCase,
    this._removeProductUseCase,
    this._updateProductUseCase,
    this._getCategoriesUseCase,
    this._addToCartUseCase,
    this._countCartItemUseCase,
  );
  @override
  void onInit() async {
    super.onInit();
    _initialize();
    countCartItem();
    scrollController.addListener(_onScroll);
  }

  @override
  void onClose() {
    nameEditingController.dispose();
    codeEditingController.dispose();
    priceEditingController.dispose();
    stockEditingController.dispose();
    descriptionEditingController.dispose();
    imageEditingController.dispose();
    scrollController.dispose();
    searchController.dispose();
    nameProductFocusNode.dispose();
    codeProductFocusNode.dispose();
    priceProductFocusNode.dispose();
    stockProductFocusNode.dispose();
    descriptionProductFocusNode.dispose();
    imageProductFocusNode.dispose();
    super.onClose();
  }

  Future<void> _initialize() async {
    await loadCategoriesList();
    await loadProductList();
  }

  void applyFilter() {
    Iterable<Product> result = productList;

    if (selectedCategory.value != null) {
      result = result.where((e) => e.category.id == selectedCategory.value!.id);
    }

    if (searchController.text.isNotEmpty) {
      result = result.where(
        (e) =>
            e.name.toLowerCase().contains(searchController.text.toLowerCase()),
      );
    }

    displayedProducts.assignAll(result);
  }

  void searchProduct(String _) {
    applyFilter();
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

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreProduct();
    }
  }

  Future<void> handleRefresh() async {
    _page = 1;
    _hasMore = true;
    isLoadingMore.value = false;

    await loadProductList(reset: true);
  }

  Future<void> loadProductList({bool reset = false}) async {
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = null;
    try {
      if (reset) {
        _page = 1;
        _hasMore = true;
        isLoadingMore.value = false;
        selectedCategory.value = null;
      }
      productList.assignAll(
        await _getProductListUseCase(
          GetPaginationParams(page: _page, limit: _limit),
        ),
      );
      applyFilter();
      if (productList.length < _limit) {
        _hasMore = false;
      }
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

  void loadMoreProduct() async {
    if (isLoadingMore.value || !_hasMore) return;
    isLoadingMore.value = true;
    try {
      _page++;
      final List<Product> newProductList = await _getProductListUseCase(
        GetPaginationParams(page: _page, limit: _limit),
      );
      if (newProductList.isEmpty) {
        _hasMore = false;
      } else {
        productList.addAll(newProductList);
        applyFilter();
        if (newProductList.length < _limit) {
          _hasMore = false;
        }
      }
    } on UnauthorizedException {
      BaseUnauthorized.handleUnauthorized();
    } catch (e) {
      print("Error loading products: $e");
      isError.value = true;
      errorMessage.value = "Danh sách sản phẩm trống";
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> addProduct() async {
    if (isLoading.value) return;
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = null;
    try {
      final category = selectedCategory.value ?? categoriesList.first;
      final newProduct = Product(
        999,
        nameEditingController.text,
        codeEditingController.text,
        double.parse(priceEditingController.text),
        int.parse(stockEditingController.text),
        category,
        descriptionEditingController.text,
        imageEditingController.text,
      );
      await _addProductUseCase(newProduct);
      Get.back();
      Get.snackbar(
        "Thành công",
        "Bạn đã thêm sản phẩm thành công",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      await loadProductList(reset: true);
    } on UnauthorizedException {
      BaseUnauthorized.handleUnauthorized();
    } catch (e) {
      Get.snackbar(
        "Thất bại",
        "Không thể thêm sản phẩm: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void removeProduct(int id) async {
    if (isLoading.value) return;
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = null;
    try {
      final cartService = Get.find<CartService>();
      await _removeProductUseCase(id);
      await cartService.removeCart(id);
      countCartItem();
      Get.snackbar(
        "Thành công",
        "Bạn đã xóa sản phẩm thành công",
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      await loadProductList(reset: true);
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
      await loadProductList(reset: true);
    } on UnauthorizedException {
      BaseUnauthorized.handleUnauthorized();
    } catch (e) {
      Get.snackbar(
        "Thất bại",
        "Không thể cập nhật sản phẩm: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.red,
        duration: Duration(seconds: 2),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void addToCart(Product product) async {
    final cart = Cart(
      product.id,
      product.name,
      product.code,
      product.price,
      product.stock,
      product.category,
      product.description,
      product.image,
    );
    await _addToCartUseCase(cart);
    countCartItem();
  }

  void countCartItem() async {
    countItem.value = await _countCartItemUseCase(const NoParams());
  }
}
