import 'package:prjgetxproduct/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/cart/domain/repositories/cart_repository.dart';

class GetCartListUseCase {
  final CartRepository _cartRepository;
  GetCartListUseCase(this._cartRepository);
  List<Cart> call() {
    return _cartRepository.getCartList();
  }
}
