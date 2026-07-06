import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:prjgetxproduct/service/auth_service.dart';
import 'package:prjgetxproduct/routes/page_route.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    if (!authService.isLoggedIn.value && route != AppRoute.INITIAL) {
      return RouteSettings(name: AppRoute.INITIAL);
    }
    return null;
  }
}
