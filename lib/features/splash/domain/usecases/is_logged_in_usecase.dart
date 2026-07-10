import 'package:prjgetxproduct/features/splash/domain/repositories/splash_repository.dart';

class IsLoggedInUseCase {
  final SplashRepository _splashRepository;
  IsLoggedInUseCase(this._splashRepository);
  bool call() {
    return _splashRepository.isLoggedIn();
  }
}
