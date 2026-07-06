import 'package:prjgetxproduct/product/domain/entities/category.dart';

class CategoryModel {
  final int id;
  final String name;
  CategoryModel(this.id, this.name);
  static CategoryModel mapToCategoryModel(Category category) {
    return CategoryModel(category.id, category.name);
  }

  static CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel(json['id'], json['name']);
  }
}
