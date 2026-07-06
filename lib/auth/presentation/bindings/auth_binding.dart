import 'package:get/get.dart';
import 'package:prjgetxproduct/auth/data/datasources/auth_remote_datasource.dart';
import 'package:prjgetxproduct/auth/data/repositories/auth_repository_impl.dart';
import 'package:prjgetxproduct/auth/domain/repositories/auth_repository.dart';

import 'package:prjgetxproduct/auth/domain/usecases/login_usecase.dart';
import 'package:prjgetxproduct/auth/domain/usecases/logout_usecase.dart';
import 'package:prjgetxproduct/auth/presentation/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find()));
    Get.lazyPut<LogoutUseCase>(() => LogoutUseCase(Get.find()));

    Get.lazyPut<AuthController>(
      () => AuthController(loginUseCase: Get.find(), logoutUseCase: Get.find()),
    );
  }
}
