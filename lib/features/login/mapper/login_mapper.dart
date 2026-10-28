import 'package:prjgetxproduct/features/login/data/models/login_model.dart';

class LoginMapper {
  static Map<String, dynamic> toJson(LoginModel loginModel) {
    return {'username': loginModel.username, 'password': loginModel.password};
  }
}
