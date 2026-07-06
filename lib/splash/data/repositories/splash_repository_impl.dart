import 'package:prjgetxproduct/splash/data/datasources/splash_local_datasource.dart';
import 'package:prjgetxproduct/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl extends SplashRepository {
  final SplashLocalDatasource _splashLocalDatasource;
  SplashRepositoryImpl(this._splashLocalDatasource);

  @override
  bool isLoggedIn() {
    return _splashLocalDatasource.isLoggedIn();
  }
}
