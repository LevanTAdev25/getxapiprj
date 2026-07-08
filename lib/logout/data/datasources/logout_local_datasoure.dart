import 'package:get/get.dart';
import 'package:prjgetxproduct/routes/page_app.dart';
import 'package:prjgetxproduct/service/auth_service.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

abstract class LogoutLocalDatasource {
  Future<void> logout();
}

class LogoutLocalDatasoureImpl implements LogoutLocalDatasource {
  final AuthService _authService;
  final CartService _cartService;
  LogoutLocalDatasoureImpl(this._authService, this._cartService);
  @override
  Future<void> logout() async {
    _authService.clearToken();
    _cartService.clearCart();
    Get.offAllNamed(AppPage.LOGIN);
  }
}
