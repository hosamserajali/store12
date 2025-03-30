import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart'; 
import 'package:store/controllers/products/products_controller.dart';
import 'package:store/core/color/app_colors.dart';
import 'package:store/view/products/searchview.dart';
import 'package:store/view/products/product_details_view.dart';

class HomepageView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Discover',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.primary),
            onPressed: () => Get.to(() => SearchView()),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for clothes...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: Icon(Icons.filter_list, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (query) {
                productController.filterProducts(query);
              },
            ),
          ),

          Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: productController.categories.map((category) {
                    bool isSelected = productController.selectedCategory.value == category;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        selectedColor: AppColors.primary,
                        backgroundColor: Colors.grey[200],
                        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                        onSelected: (selected) {
                          productController.selectCategory(category);
                        },
                      ),
                    );
                  }).toList(),
                ),
              )),

          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (productController.filteredProducts.isEmpty) {
                return Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }
              return GridView.builder(
                padding: EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.65, 
                ),
                itemCount: productController.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = productController.filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ProductDetailsView(product: product));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: Color(0xFFE6E6E6), 
                                  child: productController.isLoading.value
                                      ? Shimmer.fromColors(
                                          baseColor: Color(0xFFB3B3B3),
                                          highlightColor: Color(0xFFE0E0E0),
                                          child: Container(
                                            width: double.infinity,
                                            height: 140,
                                            color: Colors.white,
                                          ),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: product.image,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => Shimmer.fromColors(
                                            baseColor: Color(0xFFB3B3B3),
                                            highlightColor: Color(0xFFE0E0E0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 140,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => Center(
                                            child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                                          ),
                                        ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Obx(() => Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white, 
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          productController.isSaved(product) ? Icons.favorite : Icons.favorite_border,
                                          color: productController.isSaved(product) ? Colors.red : Colors.grey,
                                        ),
                                        onPressed: () {
                                          productController.toggleSaved(product);
                                        },
                                      ),
                                    ))),
                            ],
                          ),
                        ),

                   
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '\$${product.price}',
                                style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
