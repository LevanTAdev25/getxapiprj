import 'package:prjgetxproduct/auth/domain/entities/auth.dart';
import 'package:prjgetxproduct/auth/domain/repositories/auth_repository.dart';
import 'package:prjgetxproduct/base/base_usecase.dart';

class LoginUseCase extends BaseUseCase<void, Auth> {
  final AuthRepository _authRepository;
  LoginUseCase(this._authRepository);
  @override
  Future<void> call(Auth auth) async {
    await _authRepository.login(auth);
  }
}
