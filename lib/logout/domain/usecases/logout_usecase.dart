import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/base/params/no_params.dart';
import 'package:prjgetxproduct/logout/domain/repositories/logout_repository.dart';

class LogoutUseCase extends BaseUseCase<void, NoParams> {
  final LogoutRepository _logoutRepository;
  LogoutUseCase(this._logoutRepository);
  @override
  Future<void> call(NoParams params) async {
    await _logoutRepository.logout();
  }
}
