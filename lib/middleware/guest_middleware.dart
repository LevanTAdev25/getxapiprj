import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/routes/page_app.dart';
import 'package:prjgetxproduct/service/auth_service.dart';

class GuestMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    if (authService.isLoggedIn.value && route == AppPage.LOGIN) {
      return RouteSettings(name: AppPage.PRODUCTS);
    }
  }
}
