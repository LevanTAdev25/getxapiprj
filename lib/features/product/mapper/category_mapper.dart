import 'package:prjgetxproduct/features/product/data/models/category_model.dart';
import 'package:prjgetxproduct/features/product/domain/entities/category.dart';

class CategoryMapper {
  static Category mapToCategory(CategoryModel categoryModel) {
    return Category(categoryModel.id, categoryModel.name);
  }
}
