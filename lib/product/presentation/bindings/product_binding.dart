import 'package:get/get.dart';
import 'package:prjgetxproduct/product/data/datasources/products_remote_datasource.dart';
import 'package:prjgetxproduct/product/data/repositories/product_repository_impl.dart';
import 'package:prjgetxproduct/product/domain/repositories/product_repository.dart';
import 'package:prjgetxproduct/product/domain/usecases/add_product_usecase.dart';
import 'package:prjgetxproduct/product/domain/usecases/get_categories_usecase.dart';
import 'package:prjgetxproduct/product/domain/usecases/get_product_list_usecase.dart';
import 'package:prjgetxproduct/product/domain/usecases/remove_product_usecase.dart';
import 'package:prjgetxproduct/product/domain/usecases/update_product_usecase.dart';
import 'package:prjgetxproduct/product/presentation/controllers/product_controller.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() async {
    await Get.putAsync<CartService>(
      () => CartService().init(),
      permanent: true,
    );
    Get.lazyPut<ProductsRemoteDatasource>(() => ProductsRemoteDatasourceImpl());
    Get.lazyPut<ProductRepository>(() => ProductRepositoryImpl(Get.find()));
    Get.lazyPut<AddProductUseCase>(() => AddProductUseCase(Get.find()));
    Get.lazyPut<GetProductListUseCase>(() => GetProductListUseCase(Get.find()));
    Get.lazyPut<RemoveProductUseCase>(() => RemoveProductUseCase(Get.find()));
    Get.lazyPut<UpdateProductUseCase>(() => UpdateProductUseCase(Get.find()));
    Get.lazyPut<GetCategoriesUseCase>(() => GetCategoriesUseCase(Get.find()));
    Get.lazyPut<ProductController>(
      () => ProductController(
        Get.find<GetProductListUseCase>(),
        Get.find<AddProductUseCase>(),
        Get.find<RemoveProductUseCase>(),
        Get.find<UpdateProductUseCase>(),
        Get.find<GetCategoriesUseCase>(),
      ),
    );
  }
}
