import 'package:get/get.dart';
import 'package:prjgetxproduct/logout/data/datasources/logout_local_datasoure.dart';
import 'package:prjgetxproduct/logout/data/repositories/logout_repository_impl.dart';
import 'package:prjgetxproduct/logout/domain/repositories/logout_repository.dart';
import 'package:prjgetxproduct/logout/domain/usecases/logout_usecase.dart';
import 'package:prjgetxproduct/logout/presentation/controllers/logout_controller.dart';

class LogoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LogoutLocalDatasource>(
      () => LogoutLocalDatasoureImpl(Get.find(), Get.find()),
    );
    Get.lazyPut<LogoutRepository>(() => LogoutRepositoryImpl(Get.find()));
    Get.lazyPut<LogoutUseCase>(() => LogoutUseCase(Get.find()));
    Get.lazyPut<LogoutController>(
      () => LogoutController(Get.find<LogoutUseCase>()),
    );
  }
}
