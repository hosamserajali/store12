import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/cart/cart_controller.dart';
import 'package:store/core/color/app_colors.dart';
import 'package:store/models/product_model.dart';

class ProductDetailsView extends StatelessWidget {
  final ProductModel product;
  final CartController cartController = Get.put(CartController());

  ProductDetailsView({required this.product});

  @override
  Widget build(BuildContext context) {
    RxBool isFavorite = false.obs;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Details', style: TextStyle(color: AppColors.primary)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.image,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Obx(() => GestureDetector(
                        onTap: () {
                          isFavorite.toggle();
                          Get.snackbar(
                            isFavorite.value ? 'Success' : 'Removed',
                            isFavorite.value
                                ? '${product.name} added to favorites!'
                                : '${product.name} removed from favorites',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: isFavorite.value ? AppColors.success : Colors.grey,
                            colorText: Colors.white,
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            isFavorite.value ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite.value ? Colors.red : Colors.black,
                          ),
                        ),
                      )),
                ),
              ],
            ),
            SizedBox(height: 30),

           
            Text(product.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),

          
            Row(
              children: [
                Icon(Icons.star, color: Colors.orange, size: 20),
                SizedBox(width: 4),
                Text('4.0/5', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(width: 4),
                Text('(45 reviews)', style: TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
            SizedBox(height: 30),

          
            Text(
              product.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
         
          ],
        ),
      ),


      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
     
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),

            ElevatedButton.icon(
              onPressed: () {
                cartController.addToCart(product);
                Get.snackbar(
                  'Success',
                  '${product.name} added to cart!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
              icon: Icon(Icons.add_shopping_cart, color: Colors.white),
              label: Text('Add to Cart', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
