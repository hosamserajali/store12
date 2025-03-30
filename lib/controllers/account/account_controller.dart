import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/routes/app_routes.dart';

class AccountController extends GetxController {
  void showLogoutDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.rotate(
                angle: 3.14,
                child: Icon(Icons.warning_amber_rounded, color: Color(0xFFED1010), size: 50),
              ),
              SizedBox(height: 16),
              Text("Logout?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(
                "Are you sure you want to logout?",
                style: TextStyle(color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFED1010),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: logout,
                    child: Text("Yes, Logout", style: TextStyle(color: Colors.white)),
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text("No, Cancel", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout() {
    Get.back(); 
    Future.delayed(Duration(milliseconds: 300), () {
      Get.offAllNamed(AppRoutes.login);   
    });
  }
}