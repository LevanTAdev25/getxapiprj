import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/login/domain/entities/login.dart';
import 'package:prjgetxproduct/login/domain/repositories/login_repository.dart';

class LoginUseCase extends BaseUseCase<void, Login> {
  final LoginRepository _loginRepository;
  LoginUseCase(this._loginRepository);
  @override
  Future<void> call(Login auth) async {
    await _loginRepository.login(auth);
  }
}
