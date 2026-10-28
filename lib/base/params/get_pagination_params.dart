import 'package:prjgetxproduct/features/product/domain/entities/category.dart';

class GetPaginationParams {
  final int page;
  final int limit;
  final Category? category;
  GetPaginationParams({required this.page, required this.limit, this.category});
}
