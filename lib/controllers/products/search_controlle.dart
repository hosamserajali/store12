import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/services/api_service.dart';
import 'package:store/models/product_model.dart';

class SearchProductController extends GetxController { 
  TextEditingController searchTextController = TextEditingController(); 
  var searchResults = <ProductModel>[].obs;
  var isLoading = false.obs;

  void searchProducts(String query) async {
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isLoading(true);
      var allProducts = await ProductService.getProducts();
      searchResults.assignAll(
        allProducts
            .where((product) => product.name.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch products');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
