import 'package:get/get.dart';
import 'package:store/controllers/auth/auth_controller.dart';
import 'package:store/controllers/products/products_controller.dart';
import 'package:store/controllers/products/search_controlle.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
  Get.put(AuthController());
  Get.put(SearchProductController());
  Get.put(ProductController());

  }
  
}