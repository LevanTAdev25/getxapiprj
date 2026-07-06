import 'package:prjgetxproduct/logout/data/datasources/logout_local_datasoure.dart';
import 'package:prjgetxproduct/logout/domain/repositories/logout_repository.dart';

class LogoutRepositoryImpl extends LogoutRepository {
  final LogoutLocalDatasource _logoutLocalDatasource;
  LogoutRepositoryImpl(this._logoutLocalDatasource);
  @override
  Future<void> logout() async {
    await _logoutLocalDatasource.logout();
  }
}
