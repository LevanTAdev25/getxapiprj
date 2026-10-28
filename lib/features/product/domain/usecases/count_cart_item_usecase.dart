import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/base/params/no_params.dart';
import 'package:prjgetxproduct/features/product/domain/repositories/product_repository_src.dart';

class CountCartItemUseCase extends BaseUseCase<int, NoParams> {
  final ProductRepository _productRepository;
  CountCartItemUseCase(this._productRepository);

  @override
  Future<int> call(NoParams params) async {
    return await _productRepository.countCartItem();
  }
}
