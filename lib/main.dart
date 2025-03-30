import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/binding/init.dart';
import 'package:store/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBinding(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,

    );
  }
}
  
  