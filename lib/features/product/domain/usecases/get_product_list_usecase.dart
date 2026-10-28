import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/base/params/get_pagination_params.dart';
import 'package:prjgetxproduct/features/product/domain/entities/product.dart';
import 'package:prjgetxproduct/features/product/domain/repositories/product_repository.dart';

class GetProductListUseCase
    extends BaseUseCase<List<Product>, GetPaginationParams> {
  final ProductRepository _productRepository;
  GetProductListUseCase(this._productRepository);
  @override
  Future<List<Product>> call(GetPaginationParams params) async {
    return await _productRepository.getProductList(params);
  }
}
