import 'package:dio/dio.dart';
import 'package:prjgetxproduct/api/config_api.dart';
import 'package:prjgetxproduct/exception/unauthorized_exception.dart';
import 'package:prjgetxproduct/login/data/models/login_model.dart';
import 'package:prjgetxproduct/service/auth_service.dart';

abstract class LoginRemoteDatasource {
  Future<void> login(LoginModel loginModel);
  Future<void> logout();
}

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final AuthService _authService;
  LoginRemoteDatasourceImpl(this._authService);
  @override
  Future<void> login(LoginModel loginModel) async {
    try {
      final jsonData = LoginModel.toJson(loginModel);
      final response = await DataApi().dio.post("/login", data: jsonData);
      if (response.data['data']['access_token'] != null) {
        final userWithToken = loginModel.copyWith(
          token: response.data['data']['access_token'],
        );
        await _authService.putToken(userWithToken);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? "Lỗi khi xử lý dữ liệu";
        throw Exception(message);
      }
      throw Exception("Lỗi kết nối mạng hoặc máy chủ server có vấn đề");
    }
  }

  @override
  Future<void> logout() async {
    _authService.isLoggedIn.value = false;
    await _authService.clearToken();
  }
}
