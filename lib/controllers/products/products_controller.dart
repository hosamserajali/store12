
import 'package:get/get.dart';
import 'package:store/models/product_model.dart';
import 'package:store/routes/app_routes.dart';
import 'package:store/services/api_service.dart';

class ProductController extends GetxController {
  var products = <ProductModel>[].obs;
  var savedProducts = <ProductModel>[].obs;
  var filteredProducts = <ProductModel>[].obs;
  var categories = <String>[].obs;
  var isLoading = false.obs;

  var selectedIndex = 0.obs;
  var selectedCategory = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var fetchedProducts = await ProductService.getProducts();
      if (fetchedProducts.isNotEmpty) {
        products.assignAll(fetchedProducts);
        extractCategories();
        filterProductsByCategory();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load products');
    } finally {
      isLoading(false);
    }
  }


  void extractCategories() {
    var categorySet = <String>{};
    for (var product in products) {
      categorySet.add(product.category);
    }
    categories.assignAll(['All', ...categorySet]);
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    filterProductsByCategory();
  }

  void filterProductsByCategory() {
    if (selectedCategory.value == 'All') {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products.where((product) =>
          product.category.toLowerCase() == selectedCategory.value.toLowerCase()).toList(),
      );
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filterProductsByCategory();
    } else {
      filteredProducts.assignAll(
        products.where((product) => 
          product.name.toLowerCase().contains(query.toLowerCase()) &&
          (selectedCategory.value == 'All' || product.category.toLowerCase() == selectedCategory.value.toLowerCase())
        ).toList(),
      );
    }
  }

  void changeTab(int index) {
    if (selectedIndex.value == index) return; // ✅ تجنب إعادة تحميل الصفحة الحالية
    selectedIndex.value = index;

    switch (index) {
      case 0:
       Get.to(AppRoutes.homepage);
        break;
      case 1:
            Get.to(AppRoutes.seved);
        break;
      case 2:
          Get.to(AppRoutes.cart);
        break;
      case 3:
           Get.to(AppRoutes.account);
        break;
      default:
        break;
    }
  }

  void toggleSaved(ProductModel product) {
    if (isSaved(product)) {
      savedProducts.removeWhere((p) => p.id == product.id);
    } else {
      savedProducts.add(product);
    }
  }

  bool isSaved(ProductModel product) {
    return savedProducts.any((p) => p.id == product.id);
  }
}

class SavedItemsController extends GetxController {
  var savedProducts = <ProductModel>[].obs;

  void toggleSaved(ProductModel product) {
    if (isSaved(product)) {
      savedProducts.removeWhere((p) => p.id == product.id);
    } else {
      savedProducts.add(product);
    }
  }

  bool isSaved(ProductModel product) {
    return savedProducts.any((p) => p.id == product.id);
  }
  
}
