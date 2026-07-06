import 'package:prjgetxproduct/auth/domain/repositories/auth_repository.dart';
import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/base/params/no_params.dart';

class LogoutUseCase extends BaseUseCase<void, NoParams> {
  final AuthRepository _authRepository;
  LogoutUseCase(this._authRepository);
  @override
  Future<void> call(NoParams params) async {
    await _authRepository.logout();
  }
}
