import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prjgetxproduct/features/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/features/login/data/models/login_model.dart';
import 'package:prjgetxproduct/features/product/data/models/category_model.dart';

import 'package:prjgetxproduct/routes/page_route.dart';
import 'package:prjgetxproduct/service/auth_service.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Hive.initFlutter();
    Hive.registerAdapter(LoginModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
    Hive.registerAdapter(CartModelAdapter());
    await Get.putAsync<AuthService>(
      () => AuthService().init(),
      permanent: true,
    );
    await Get.putAsync<CartService>(
      () => CartService().init(),
      permanent: true,
    );
  } catch (e, s) {
    debugPrint(e.toString());
    debugPrintStack(stackTrace: s);

    return; // hoặc hiển thị một app lỗi
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoute.INITIAL,
      getPages: AppRoute.pages,
    );
  }
}
