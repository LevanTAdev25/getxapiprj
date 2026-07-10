import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/features/product/domain/repositories/product_repository.dart';

class RemoveProductUseCase extends BaseUseCase<void, int> {
  final ProductRepository _productRepository;
  RemoveProductUseCase(this._productRepository);

  @override
  Future<void> call(int id) async {
    await _productRepository.removeProduct(id);
  }
}
