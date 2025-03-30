import 'package:get/get.dart';
import 'package:store/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  var cartItems = <ProductModel>[].obs;
  final String apiUrl = "https://dummyjson.com/carts";

  @override
  void onInit() {
    loadCartFromStorage();
    super.onInit();
  }

  Future<void> fetchCartItems() async {
    if (cartItems.isNotEmpty) return;
    try {
      final response = await http.get(Uri.parse('$apiUrl/1'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<ProductModel> fetchedProducts = (data['products'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
        cartItems.assignAll(fetchedProducts);
        saveCartToStorage();
      } else {
        print("❌ Failed to fetch cart: ${response.body}");
      }
    } catch (e) {
      print("❌ Error fetching cart: $e");
    }
  }

  Future<void> addToCart(ProductModel product) async {
    try {
      var existingItem = cartItems.firstWhereOrNull((item) => item.id == product.id);
      if (existingItem != null) {
        increaseQuantity(existingItem);
      } else {
        product.quantity.value = 1;
        cartItems.add(product);
        saveCartToStorage(); 
      }
    } catch (e) {
      print("❌ Error adding to cart: $e");
    }
  }


  void removeItem(ProductModel product) {
    cartItems.removeWhere((item) => item.id == product.id);
    saveCartToStorage(); 
  }


  void increaseQuantity(ProductModel product) {
    product.quantity.value++;
    saveCartToStorage();
  }


  void decreaseQuantity(ProductModel product) {
    if (product.quantity.value > 1) {
      product.quantity.value--;
    } else {
      removeItem(product);
    }
    saveCartToStorage();
  }


  void clearCart() {
    cartItems.clear();
    saveCartToStorage();
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity.value));

  Future<void> saveCartToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJson = cartItems.map((item) => json.encode(item.toJson())).toList();
    await prefs.setStringList('cart', cartJson);
  }

  Future<void> loadCartFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList('cart');
    if (cartJson != null && cartJson.isNotEmpty) {
      cartItems.assignAll(cartJson.map((item) => ProductModel.fromJson(json.decode(item))).toList());
    } else {
      cartItems.clear();
    }
  }
}
