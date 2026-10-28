import 'package:get/get.dart';
import 'package:prjgetxproduct/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:prjgetxproduct/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:prjgetxproduct/features/cart/domain/repositories/cart_repository.dart';
import 'package:prjgetxproduct/features/cart/domain/usecase/cart_usecase_src.dart';
import 'package:prjgetxproduct/features/cart/presentation/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartLocalDatasource>(
      () => CartLocalDatasourceImpl(Get.find(), Get.find()),
    );
    Get.lazyPut<CartRepository>(() => CartRepositoryImpl(Get.find()));
    Get.lazyPut<GetCartListUseCase>(() => GetCartListUseCase(Get.find()));
    Get.lazyPut<RemoveCartUseCase>(() => RemoveCartUseCase(Get.find()));
    Get.lazyPut<DecreaseCartUseCase>(() => DecreaseCartUseCase(Get.find()));
    Get.lazyPut<IncreaseCartUseCase>(() => IncreaseCartUseCase(Get.find()));
    Get.lazyPut<CartController>(
      () => CartController(
        Get.find<GetCartListUseCase>(),
        Get.find<RemoveCartUseCase>(),
        Get.find<DecreaseCartUseCase>(),
        Get.find<IncreaseCartUseCase>(),
      ),
    );
  }
}
