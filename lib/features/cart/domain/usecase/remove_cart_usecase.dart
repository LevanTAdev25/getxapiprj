import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/features/cart/domain/repositories/cart_repository.dart';

class RemoveCartUseCase extends BaseUseCase<void, int> {
  final CartRepository _cartRepository;
  RemoveCartUseCase(this._cartRepository);

  @override
  Future<void> call(int id) async {
    await _cartRepository.removeCart(id);
  }
}
