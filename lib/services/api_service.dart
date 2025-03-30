
import 'package:http/http.dart' as http;
import 'package:store/models/product_model.dart';
import 'dart:convert';

class ProductService {
  static Future<List<ProductModel>> getProducts({String category = 'All'}) async {
    String url = 'https://dummyjson.com/products';
    
    if (category != 'All') {
      url = 'https://dummyjson.com/products/category/$category';
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> productsJson = data['products'] ?? data; 
        return productsJson.map((json) => ProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}