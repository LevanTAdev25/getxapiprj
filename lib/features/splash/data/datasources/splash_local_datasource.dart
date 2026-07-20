import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:prjgetxproduct/service/auth_service.dart';

abstract class SplashLocalDatasource {
  bool isLoggedIn();
}

class SplashLocalDatasourceImpl implements SplashLocalDatasource {
  final AuthService _authService;
  SplashLocalDatasourceImpl(this._authService);
  @override
  bool isLoggedIn() {
    final token = _authService.getToken();
    if (token == null) {
      return false;
    }
    return _authService.isLoggedIn.value && !JwtDecoder.isExpired(token.token!);
  }
}
