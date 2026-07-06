import 'package:prjgetxproduct/auth/data/datasources/auth_remote_datasource.dart';
import 'package:prjgetxproduct/auth/data/models/auth_model.dart';
import 'package:prjgetxproduct/auth/domain/entities/auth.dart';
import 'package:prjgetxproduct/auth/domain/repositories/auth_repository.dart';
import 'package:prjgetxproduct/service/auth_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepositoryImpl(this._authRemoteDatasource);
  @override
  Future<void> login(Auth user) async {
    final authModel = AuthModel(user.username, user.password);
    await _authRemoteDatasource.login(authModel);
  }

  @override
  Future<void> logout() async {
    await _authRemoteDatasource.logout();
  }
}
