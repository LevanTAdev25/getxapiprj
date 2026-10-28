import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/features/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/features/cart/domain/repositories/cart_repository.dart';

class IncreaseCartUseCase extends BaseUseCase<void, Cart> {
  final CartRepository _cartRepository;
  IncreaseCartUseCase(this._cartRepository);
  @override
  Future<void> call(Cart cart) async {
    await _cartRepository.increaseCart(cart);
  }
}
