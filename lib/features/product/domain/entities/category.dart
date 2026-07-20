import 'package:prjgetxproduct/features/product/data/models/category_model.dart';

class Category {
  int id;
  String name;
  Category(this.id, this.name);
  static Category mapToCategory(CategoryModel categoryModel) {
    return Category(categoryModel.id, categoryModel.name);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
