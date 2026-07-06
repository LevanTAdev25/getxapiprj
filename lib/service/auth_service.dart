import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthService extends GetxService {
  late Box<String> _authBox;
  final isLoggedIn = false.obs;
  Future<AuthService> init() async {
    _authBox = await Hive.openBox<String>("session");
    if (getToken() != null) {
      isLoggedIn.value = true;
    }
    return this;
  }

  String? getToken() {
    return _authBox.get("access_token");
  }

  Future<void> putToken(String token) async {
    await _authBox.put("access_token", token);
    isLoggedIn.value = true;
  }

  Future<void> clearToken() async {
    await _authBox.clear();
    isLoggedIn.value = false;
  }
}
