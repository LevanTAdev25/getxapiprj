import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/features/product/domain/entities/product.dart';
import 'package:prjgetxproduct/features/product/domain/repositories/product_repository.dart';

class AddProductUseCase extends BaseUseCase<void, Product> {
  final ProductRepository _productRepository;
  AddProductUseCase(this._productRepository);

  @override
  Future<void> call(Product newProduct) async {
    await _productRepository.addProduct(newProduct);
  }
}
