import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:prjgetxproduct/cart/data/models/cart_model.dart';
import 'package:prjgetxproduct/login/data/models/login_model.dart';
import 'package:prjgetxproduct/product/data/models/category_model.dart';

import 'package:prjgetxproduct/routes/page_route.dart';
import 'package:prjgetxproduct/service/auth_service.dart';
import 'package:prjgetxproduct/service/cart_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(LoginModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(CartModelAdapter());
  await Get.putAsync<AuthService>(() => AuthService().init(), permanent: true);
  await Get.putAsync<CartService>(() => CartService().init(), permanent: true);
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
