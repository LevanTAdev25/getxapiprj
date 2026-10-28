import 'package:hive_flutter/hive_flutter.dart';
part 'login_model.g.dart';

@HiveType(typeId: 1)
class LoginModel {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String password;
  @HiveField(2)
  final String? token;
  LoginModel(this.username, this.password, {this.token});
  static Map<String, dynamic> toJson(LoginModel loginModel) {
    return {'username': loginModel.username, 'password': loginModel.password};
  }

  LoginModel copyWith({String? username, String? password, String? token}) {
    return LoginModel(
      username ?? this.username,
      password ?? this.password,
      token: token ?? this.token,
    );
  }
}
