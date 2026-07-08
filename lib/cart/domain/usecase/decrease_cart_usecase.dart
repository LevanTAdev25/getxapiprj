import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/cart/domain/repositories/cart_repository.dart';

class DecreaseCartUseCase extends BaseUseCase<void, Cart> {
  final CartRepository _cartRepository;
  DecreaseCartUseCase(this._cartRepository);
  @override
  Future<void> call(Cart cart) async {
    await _cartRepository.decreaseCart(cart);
  }
}
