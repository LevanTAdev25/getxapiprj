import 'package:get/get.dart';
import 'package:prjgetxproduct/base/params/no_params.dart';
import 'package:prjgetxproduct/logout/domain/usecases/logout_usecase.dart';

class LogoutController extends GetxController {
  final LogoutUseCase _logoutUseCase;
  LogoutController(this._logoutUseCase);
  void logout() async {
    await _logoutUseCase(const NoParams());
  }
}
