import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/view/products/homepage_view.dart';
import 'package:store/view/products/saveditems_view.dart';
import 'package:store/view/cart/cart_view.dart';
import 'package:store/view/account/account_view.dart';
import 'package:store/core/color/app_colors.dart';
import 'package:store/controllers/products/products_controller.dart';

class MainPageView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  final List<Widget> pages = [
    HomepageView(),
    SavedItemsView(),
    CartView(),
    AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[productController.selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: productController.selectedIndex.value,
            onTap: (index) {
              productController.changeTab(index);
            },
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home, color: AppColors.primary),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite, color: AppColors.primary),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                activeIcon: Icon(Icons.shopping_cart, color: AppColors.primary),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person, color: AppColors.primary),
                label: 'Account',
              ),
            ],
          ),
        ),
    );
  }
}
