import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/product/domain/entities/product.dart';
import 'package:prjgetxproduct/product/domain/repositories/product_repository.dart';

class UpdateProductUseCase extends BaseUseCase<void, Product> {
  final ProductRepository _productRepository;
  UpdateProductUseCase(this._productRepository);

  @override
  Future<void> call(Product product) async {
    await _productRepository.updateProduct(product);
  }
}
