import 'package:prjgetxproduct/features/login/domain/entities/login.dart';

abstract class LoginRepository {
  Future<void> login(Login user);
}
