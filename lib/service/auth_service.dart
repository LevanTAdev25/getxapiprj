import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prjgetxproduct/login/data/models/login_model.dart';

class AuthService extends GetxService {
  late Box<LoginModel> _authBox;
  final isLoggedIn = false.obs;
  Future<AuthService> init() async {
    _authBox = await Hive.openBox<LoginModel>("session");
    if (getToken() != null) {
      isLoggedIn.value = true;
    }
    return this;
  }

  LoginModel? getToken() {
    return _authBox.get("access_token");
  }

  Future<void> putToken(LoginModel loginModel) async {
    await _authBox.put("access_token", loginModel);
    isLoggedIn.value = true;
  }

  Future<void> clearToken() async {
    await _authBox.clear();
    isLoggedIn.value = false;
  }
}
