import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/cart/domain/entities/cart.dart';
import 'package:prjgetxproduct/product/domain/repositories/product_repository.dart';

class AddToCartUseCase extends BaseUseCase<void, Cart> {
  final ProductRepository _productRepository;
  AddToCartUseCase(this._productRepository);

  @override
  Future<void> call(Cart cart) async {
    await _productRepository.addToCart(cart);
  }
}
