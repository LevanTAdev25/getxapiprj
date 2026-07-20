import 'package:get/get.dart';
import 'package:prjgetxproduct/features/cart/presentation/bindings/cart_binding.dart';
import 'package:prjgetxproduct/features/cart/presentation/pages/cart_page.dart';
import 'package:prjgetxproduct/features/login/presentation/bindings/login_binding.dart';
import 'package:prjgetxproduct/features/login/presentation/pages/login_page.dart';
import 'package:prjgetxproduct/features/product/presentation/pages/form_product_page.dart';
import 'package:prjgetxproduct/features/product/presentation/pages/detail_product_page.dart';
import 'package:prjgetxproduct/routes/page_app.dart';
import 'package:prjgetxproduct/features/product/presentation/bindings/product_binding.dart';
import 'package:prjgetxproduct/features/product/presentation/pages/product_page.dart';
import 'package:prjgetxproduct/features/splash/presentation/bindings/splash_binding.dart';
import 'package:prjgetxproduct/features/splash/presentation/pages/splash_page.dart';

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
      bindings: [ProductBinding()],
    ),
    GetPage(
      name: AppPage.FORM_PRODUCT,
      page: () => FormProductPage(),
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
