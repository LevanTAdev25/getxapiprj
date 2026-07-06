import 'package:dio/dio.dart';
import 'package:prjgetxproduct/api/config_api.dart';
import 'package:prjgetxproduct/exception/unauthorized_exception.dart';
import 'package:prjgetxproduct/product/data/models/category_model.dart';
import 'package:prjgetxproduct/product/data/models/product_model.dart';

abstract class ProductsRemoteDatasource {
  Future<List<ProductModel>> getProductModelList();
  Future<void> addProductModel(ProductModel newProductModel);
  Future<void> removeProductModel(int id);
  Future<void> updateProductModel(ProductModel productModel);
  Future<List<CategoryModel>> getCategoriesList();
}

class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  @override
  Future<void> addProductModel(ProductModel newProductModel) async {
    try {
      final dataProductJson = ProductModel.toJson(newProductModel);
      await DataApi().dio.post("/products", data: dataProductJson);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? "Dữ liệu không hợp lệ";
        throw Exception(message);
      }
    }
  }

  @override
  Future<List<ProductModel>> getProductModelList() async {
    try {
      final response = await DataApi().dio.get("/products");
      final List<ProductModel> productList = [];
      for (final productJson in response.data['data']) {
        final productModel = ProductModel.fromJson(productJson);
        productList.add(productModel);
      }
      return productList;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? "Dữ liệu không hợp lệ";
        throw Exception(message);
      }
      rethrow;
    }
  }

  @override
  Future<void> removeProductModel(int id) async {
    try {
      await DataApi().dio.delete("/products/$id");
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (e.response!.statusCode == 400) {
        final message = e.response!.data['message'] ?? "Dữ liệu không hợp lệ";
        throw Exception(message);
      }
      if (e.response!.data == 500) {
        throw Exception("Lỗi mạng, vui lòng thử lại sau");
      }
      rethrow;
    }
  }

  @override
  Future<void> updateProductModel(ProductModel productModel) async {
    try {
      final updateProductModelToJson = ProductModel.toJson(productModel);
      await DataApi().dio.put(
        "/products/${productModel.id}",
        data: updateProductModelToJson,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (e.response?.statusCode == 400) {
        final message = e.response!.data['message'] ?? "Dữ liệu không hợp lệ";
        throw Exception(message);
      }
      if (e.response?.statusCode == 500) {
        final message =
            e.response!.data['message'] ?? "Vui lòng kết nối lại mạng";
        throw Exception(message);
      }
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getCategoriesList() async {
    try {
      final response = await DataApi().dio.get("/categories");
      final List<CategoryModel> listCategoryModel = [];
      for (final categoryFromJson in response.data['data']) {
        listCategoryModel.add(CategoryModel.fromJson(categoryFromJson));
      }
      return listCategoryModel;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? "Dữ liệu không hợp lệ";
        throw Exception(message);
      }
      rethrow;
    }
  }
}
