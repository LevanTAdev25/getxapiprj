import 'package:get/get.dart';
import 'package:prjgetxproduct/routes/page_app.dart';
import 'package:prjgetxproduct/splash/domain/usecases/is_logged_in_usecase.dart';

class SplashController extends GetxController {
  final IsLoggedInUseCase _isLoggedInUseCase;
  SplashController(this._isLoggedInUseCase);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    if (isLoggedIn()) {
      Get.offNamed(AppPage.PRODUCTS);
    } else {
      Get.offNamed(AppPage.LOGIN);
    }
  }

  bool isLoggedIn() {
    return _isLoggedInUseCase();
  }
}
