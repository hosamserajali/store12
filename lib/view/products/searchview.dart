import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/products/search_controlle.dart';

class SearchView extends StatelessWidget {
  final SearchProductController  searchController = Get.put(SearchProductController ());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: searchController.searchTextController,
              onChanged: (value) => searchController.searchProducts(value),
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (searchController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (searchController.searchResults.isEmpty) {
                  return Center(child: Text('No results found'));
                }
                return ListView.builder(
                  itemCount: searchController.searchResults.length,
                  itemBuilder: (context, index) {
                    var product = searchController.searchResults[index];
                    return ListTile(
                      leading: Image.network(product.image, width: 50, height: 50),
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                      onTap: () {
                   
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
