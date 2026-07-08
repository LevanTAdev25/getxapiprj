import 'package:get/get.dart';
import 'package:prjgetxproduct/cart/presentation/bindings/cart_binding.dart';
import 'package:prjgetxproduct/cart/presentation/pages/cart_page.dart';
import 'package:prjgetxproduct/login/presentation/bindings/login_binding.dart';
import 'package:prjgetxproduct/login/presentation/pages/login_page.dart';
import 'package:prjgetxproduct/logout/presentation/bindings/logout_binding.dart';
import 'package:prjgetxproduct/product/presentation/pages/add_product_page.dart';
import 'package:prjgetxproduct/product/presentation/pages/detail_product_page.dart';
import 'package:prjgetxproduct/product/presentation/pages/update_product_page.dart';
import 'package:prjgetxproduct/routes/page_app.dart';
import 'package:prjgetxproduct/product/presentation/bindings/product_binding.dart';
import 'package:prjgetxproduct/product/presentation/pages/product_page.dart';
import 'package:prjgetxproduct/splash/presentation/bindings/splash_binding.dart';
import 'package:prjgetxproduct/splash/presentation/pages/splash_page.dart';

class AppRoute {
  static final INITIAL = AppPage.INITIAL;
  static final pages = [
    GetPage(
      name: AppRoute.INITIAL,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppPage.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppPage.PRODUCTS,
      page: () => ProductPage(),
      bindings: [ProductBinding(), LogoutBinding()],
    ),
    GetPage(
      name: AppPage.ADD_PRODUCT,
      page: () => AddProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppPage.UPDATE_PRODUCT,
      page: () => UpdateProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppPage.DETAIL_PRODUCT,
      page: () => DetailProductPage(),
      binding: ProductBinding(),
    ),
    GetPage(name: AppPage.CART, page: () => CartPage(), binding: CartBinding()),
  ];
}
