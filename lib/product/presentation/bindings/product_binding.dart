import 'package:get/get.dart';
import 'package:prjgetxproduct/product/data/datasources/product_datasource_src.dart';
import 'package:prjgetxproduct/product/data/datasources/products_remote_datasource.dart';
import 'package:prjgetxproduct/product/data/repositories/product_repository_impl.dart';
import 'package:prjgetxproduct/product/domain/repositories/product_repository.dart';
import 'package:prjgetxproduct/product/domain/usecases/product_usecase_src.dart';
import 'package:prjgetxproduct/product/presentation/controllers/product_controller.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<ProductsRemoteDatasource>(
      () => ProductsRemoteDatasourceImpl(),
      fenix: true,
    );
    Get.lazyPut<ProductLocalDatasource>(
      () => ProductLocalDatasourceImpl(Get.find()),
      fenix: true,
    );
    Get.lazyPut<ProductRepository>(
      () => ProductRepositoryImpl(
        Get.find<ProductsRemoteDatasource>(),
        Get.find<ProductLocalDatasource>(),
      ),
      fenix: true,
    );
    Get.lazyPut<AddProductUseCase>(
      () => AddProductUseCase(Get.find()),
      fenix: true,
    );
    Get.lazyPut<GetProductListUseCase>(
      () => GetProductListUseCase(Get.find()),
      fenix: true,
    );
    Get.lazyPut<RemoveProductUseCase>(
      () => RemoveProductUseCase(Get.find()),
      fenix: true,
    );
    Get.lazyPut<UpdateProductUseCase>(
      () => UpdateProductUseCase(Get.find()),
      fenix: true,
    );
    Get.lazyPut<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(Get.find()),
      fenix: true,
    );
    Get.lazyPut<AddToCartUseCase>(
      () => AddToCartUseCase(Get.find()),
      fenix: true,
    );
    Get.lazyPut<CountCartItemUseCase>(
      () => CountCartItemUseCase(Get.find()),
      fenix: true,
    );
    Get.lazyPut<ProductController>(
      () => ProductController(
        Get.find<GetProductListUseCase>(),
        Get.find<AddProductUseCase>(),
        Get.find<RemoveProductUseCase>(),
        Get.find<UpdateProductUseCase>(),
        Get.find<GetCategoriesUseCase>(),
        Get.find<AddToCartUseCase>(),
        Get.find<CountCartItemUseCase>(),
      ),
      fenix: true,
    );
    // await Get.putAsync<CartService>(
    //   () => CartService().init(),
    //   permanent: true,
    // );
  }
}
