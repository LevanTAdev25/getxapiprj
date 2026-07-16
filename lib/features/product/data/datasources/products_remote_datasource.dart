import 'package:dio/dio.dart';
import 'package:prjgetxproduct/api/config_api.dart';
import 'package:prjgetxproduct/base/params/get_pagination_params.dart';
import 'package:prjgetxproduct/exception/unauthorized_exception.dart';
import 'package:prjgetxproduct/features/product/data/models/models_src.dart';

abstract class ProductsRemoteDatasource {
  Future<List<ProductModel>> getProductModelList(
    GetPaginationParams getPaginationParams,
  );
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
      throw Exception("Lỗi kết nối mạng hoặc máy chủ server có vấn đề");
    }
  }

  @override
  Future<List<ProductModel>> getProductModelList(
    GetPaginationParams getPaginationParams,
  ) async {
    try {
      final page = getPaginationParams.page;
      final limit = getPaginationParams.limit;
      List<dynamic>? listProductModelFromJson;
      if (getPaginationParams.category == null) {
        final response = await DataApi().dio.get(
          "/products",
          queryParameters: {"page": page, "limit": limit},
        );
        listProductModelFromJson = response.data['data'];
      } else {
        final response = await DataApi().dio.get(
          "/products",
          queryParameters: {
            "page": page,
            "limit": limit,
            "category_id": getPaginationParams.category!.id,
          },
        );
        listProductModelFromJson = response.data['data'];
      }
      final List<ProductModel> productList = [];
      if (listProductModelFromJson != null) {
        for (final productJson in listProductModelFromJson) {
          final productModel = ProductModel.fromJson(productJson);
          productList.add(productModel);
        }
      }
      return productList;
    } on DioException catch (e) {
      print(e.toString());
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (e.response?.statusCode == 400) {
        final message = e.response?.data['message'] ?? "Dữ liệu không hợp lệ";
        throw Exception(message);
      }
      throw Exception("Lỗi kết nối mạng hoặc máy chủ server có vấn đề");
    }
  }

  @override
  Future<void> removeProductModel(int id) async {
    try {
      await DataApi().dio.delete("/products/$id");
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      if (e.response?.statusCode == 400) {
        final message = e.response!.data['message'] ?? "Dữ liệu không hợp lệ";
        throw Exception(message);
      }
      throw Exception("Lỗi kết nối mạng hoặc máy chủ server có vấn đề");
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
      throw Exception("Lỗi kết nối mạng hoặc máy chủ server có vấn đề");
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
      throw Exception("Lỗi kết nối mạng hoặc máy chủ server có vấn đề");
    }
  }
}
