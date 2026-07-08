import 'package:prjgetxproduct/login/domain/entities/login.dart';

abstract class LoginRepository {
  Future<void> login(Login user);
}
