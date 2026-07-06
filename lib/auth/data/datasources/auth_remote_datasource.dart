import 'package:dio/dio.dart';
import 'package:prjgetxproduct/api/config_api.dart';
import 'package:prjgetxproduct/auth/data/models/auth_model.dart';
import 'package:prjgetxproduct/exception/unauthorized_exception.dart';
import 'package:prjgetxproduct/service/auth_service.dart';

abstract class AuthRemoteDatasource {
  Future<void> login(AuthModel authModel);
  Future<void> logout();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final AuthService _authService;
  AuthRemoteDatasourceImpl(this._authService);
  @override
  Future<void> login(AuthModel authModel) async {
    try {
      final jsonData = AuthModel.toJson(authModel);
      final response = await DataApi().dio.post("/login", data: jsonData);
      if (response.data['data']['access_token'] != null) {
        await _authService.putToken(response.data['data']['access_token']);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? "Lỗi khi xử lý dữ liệu";
        throw Exception(message);
      }
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    _authService.isLoggedIn.value = false;
    await _authService.clearToken();
  }
}
