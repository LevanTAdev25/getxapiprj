import 'package:hive_flutter/hive_flutter.dart';
import 'package:prjgetxproduct/features/product/domain/entities/category.dart';
part 'category_model.g.dart';

@HiveType(typeId: 2)
class CategoryModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  CategoryModel(this.id, this.name);
  static CategoryModel mapToCategoryModel(Category category) {
    return CategoryModel(category.id, category.name);
  }

  static CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel(json['id'], json['name']);
  }
}
