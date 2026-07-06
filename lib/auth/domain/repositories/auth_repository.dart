import 'package:prjgetxproduct/auth/domain/entities/auth.dart';

abstract class AuthRepository {
  Future<void> login(Auth auth);
  Future<void> logout();
}
