import 'package:get/get.dart';
import 'package:prjgetxproduct/features/splash/data/datasources/splash_local_datasource.dart';
import 'package:prjgetxproduct/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:prjgetxproduct/features/splash/domain/repositories/splash_repository.dart';
import 'package:prjgetxproduct/features/splash/domain/usecases/is_logged_in_usecase.dart';
import 'package:prjgetxproduct/features/splash/presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashLocalDatasource>(
      () => SplashLocalDatasourceImpl(Get.find()),
    );
    Get.lazyPut<SplashRepository>(() => SplashRepositoryImpl(Get.find()));
    Get.lazyPut<IsLoggedInUseCase>(() => IsLoggedInUseCase(Get.find()));
    Get.put<SplashController>(SplashController(Get.find()));
  }
}
