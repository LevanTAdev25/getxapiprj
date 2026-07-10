import 'package:get/get.dart';
import 'package:prjgetxproduct/features/login/data/datasources/login_remote_datasource.dart';
import 'package:prjgetxproduct/features/login/data/repositories/login_repository_impl.dart';
import 'package:prjgetxproduct/features/login/domain/repositories/login_repository.dart';
import 'package:prjgetxproduct/features/login/domain/usecases/login_usecase.dart';
import 'package:prjgetxproduct/features/login/presentation/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRemoteDatasource>(
      () => LoginRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(Get.find()));
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(Get.find()));
    Get.lazyPut<LoginController>(() => LoginController(Get.find()));
  }
}
