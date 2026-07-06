import 'package:prjgetxproduct/service/auth_service.dart';

abstract class SplashLocalDatasource {
  bool isLoggedIn();
}

class SplashLocalDatasourceImpl implements SplashLocalDatasource {
  final AuthService _authService;
  SplashLocalDatasourceImpl(this._authService);
  @override
  bool isLoggedIn() {
    return _authService.isLoggedIn.value;
  }
}
