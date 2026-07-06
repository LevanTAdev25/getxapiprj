import 'package:get/get.dart';
import 'package:prjgetxproduct/routes/page_app.dart';
import 'package:prjgetxproduct/service/auth_service.dart';

abstract class LogoutLocalDatasource {
  Future<void> logout();
}

class LogoutLocalDatasoureImpl implements LogoutLocalDatasource {
  final AuthService _authService;
  LogoutLocalDatasoureImpl(this._authService);
  @override
  Future<void> logout() async {
    _authService.clearToken();
    Get.offAllNamed(AppPage.LOGIN);
  }
}
