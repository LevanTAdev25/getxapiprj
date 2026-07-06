import 'package:get/get.dart';
import 'package:prjgetxproduct/auth/presentation/bindings/auth_binding.dart';
import 'package:prjgetxproduct/auth/presentation/pages/login_page.dart';
import 'package:prjgetxproduct/product/presentation/pages/add_product_page.dart';
import 'package:prjgetxproduct/product/presentation/pages/update_product_page.dart';
import 'package:prjgetxproduct/routes/page_app.dart';
import 'package:prjgetxproduct/middleware/auth_middleware.dart';
import 'package:prjgetxproduct/middleware/guest_middleware.dart';
import 'package:prjgetxproduct/product/presentation/bindings/product_binding.dart';
import 'package:prjgetxproduct/product/presentation/pages/product_page.dart';

class AppRoute {
  static final INITIAL = AppPage.LOGIN;
  static final pages = [
    GetPage(
      name: AppRoute.INITIAL,
      page: () => LoginPage(),
      binding: AuthBinding(),
      middlewares: [GuestMiddleware()],
    ),
    GetPage(
      name: AppPage.PRODUCTS,
      page: () => ProductPage(),
      binding: ProductBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppPage.ADD_PRODUCT,
      page: () => AddProductPage(),
      binding: ProductBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: AppPage.UPDATE_PRODUCT,
      page: () => UpdateProductPage(),
      binding: ProductBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
