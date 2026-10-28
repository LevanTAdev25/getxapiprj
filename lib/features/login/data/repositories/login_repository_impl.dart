import 'package:prjgetxproduct/features/login/data/datasources/login_remote_datasource.dart';
import 'package:prjgetxproduct/features/login/data/models/login_model.dart';
import 'package:prjgetxproduct/features/login/domain/entities/login.dart';
import 'package:prjgetxproduct/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDatasource _loginRemoteDatasource;
  LoginRepositoryImpl(this._loginRemoteDatasource);
  @override
  Future<void> login(Login user) async {
    final loginModel = LoginModel(user.username, user.password);
    await _loginRemoteDatasource.login(loginModel);
  }
}
