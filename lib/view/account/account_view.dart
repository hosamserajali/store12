import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controllers/account/account_controller.dart';

import 'package:store/view/account/mydetails_view.dart';
import 'package:store/view/cart/cart_view.dart';
import 'package:store/view/products/homepage_view.dart';
import 'package:store/view/products/saveditems_view.dart';

class AccountView extends StatelessWidget {
  final AccountController controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white, 
      appBar: AppBar(
        title: Text('Account', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
     
          _buildAccountOption(Icons.person_outline, 'My profil', onTap: () {
            Get.to(MyDetailsView());  
          }),
          _buildAccountOption(Icons.home_outlined, 'Address Book',onTap: () {
            Get.to(HomepageView());  
          }),
          Divider(),
          _buildAccountOption(Icons.shopping_cart_outlined, 'My Cart',onTap: () {
            Get.to(CartView());  
          }),
               _buildAccountOption(Icons.favorite_border, 'My favorite',onTap: () {
            Get.to(SavedItemsView());  
          }),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onTap: () => controller.showLogoutDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountOption(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}

