import 'package:prjgetxproduct/base/base_usecase.dart';
import 'package:prjgetxproduct/base/params/no_params.dart';
import 'package:prjgetxproduct/features/product/domain/entities/category.dart';
import 'package:prjgetxproduct/features/product/domain/repositories/product_repository.dart';

class GetCategoriesUseCase extends BaseUseCase<List<Category>, NoParams> {
  final ProductRepository _productRepository;
  GetCategoriesUseCase(this._productRepository);
  @override
  Future<List<Category>> call(NoParams params) async {
    return await _productRepository.getCategoriesList();
  }
}
