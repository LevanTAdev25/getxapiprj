import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/base/params/no_params.dart';
import 'package:prjgetxproduct/product/domain/entities/product.dart';
import 'package:prjgetxproduct/product/domain/repositories/product_repository.dart';

class GetProductListUseCase extends BaseUseCase<List<Product>, NoParams> {
  final ProductRepository _productRepository;
  GetProductListUseCase(this._productRepository);
  @override
  Future<List<Product>> call(NoParams params) async {
    return await _productRepository.getProductList();
  }
}
