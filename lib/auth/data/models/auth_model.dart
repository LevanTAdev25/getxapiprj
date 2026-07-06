import 'package:prjgetxproduct/auth/domain/entities/auth.dart';

class AuthModel extends Auth {
  @override
  final String username;
  @override
  final String password;

  AuthModel(this.username, this.password) : super(username, password);
  static Map<String, dynamic> toJson(AuthModel authModel) {
    return {'username': authModel.username, 'password': authModel.password};
  }
}
