import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/core/color/app_colors.dart';
import 'package:store/core/color/classes/api.dart';
import 'package:store/routes/app_routes.dart';

class AuthController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(
          AppRoutes.main); 
    } else
      {Get.offAllNamed(AppRoutes.login);}
  }

  Future<void> login() async {


    final response = await Api().post('https://dummyjson.com/auth/login', {
      "username": emailController.text.trim(),
      "password": passwordController.text.trim()
    });

    if (response is Map) {
      Get.offAllNamed(AppRoutes.main);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
    } else {
      showSnackbar('Error', 'Invalid email or password', AppColors.error);
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Get.offAllNamed(
        AppRoutes.login); 
  }

  Future<void> register() async {
    String fullName = fullNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      showSnackbar('Error', 'Please fill in all fields', AppColors.error);
      return;
    }
    if (!_isValidEmail(email)) {
      showSnackbar('Error', 'Invalid email format', AppColors.error);
      return;
    }
    if (!_isValidPassword(password)) {
      showSnackbar(
          'Error',
          'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character.',
          AppColors.error);
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('registeredEmail', email);
    await prefs.setString('registeredPassword', password);

    showSnackbar('Success', 'Account Created Successfully', AppColors.success);
    Get.offNamed(AppRoutes.login); 
  }

  void forgotPassword() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      showSnackbar('Error', 'Please enter your email', AppColors.error);
      return;
    }

    if (!_isValidEmail(email)) {
      showSnackbar('Error', 'Invalid email format', AppColors.error);
      return;
    }

    try {
      print('🔹 Sending reset password code to: $email');

      showSnackbar(
          'Success', 'Reset code sent to your email', AppColors.primary);
      Get.toNamed(
          AppRoutes.resetPassword); 
    } catch (e) {
      showSnackbar(
          'Error', 'An error occurred, please try again', AppColors.error);
      print('❌ Error sending reset password code: $e');
    }
  }

  void resetPassword(String newPassword) {
    if (newPassword.isEmpty) {
      showSnackbar('Error', 'Please enter a new password', AppColors.error);
      return;
    }

    if (!_isValidPassword(newPassword)) {
      showSnackbar(
          'Error',
          'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character.',
          AppColors.error);
      return;
    }

    try {
      print('🔹 Resetting password to: $newPassword');
      showSnackbar('Success', 'Password reset successfully', AppColors.success);
      Get.offAllNamed(AppRoutes.login); 
    } catch (e) {
      showSnackbar(
          'Error', 'An error occurred, please try again', AppColors.error);
      print('❌ Error resetting password: $e');
    }
  }

  bool _isValidEmail(String email) {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(emailPattern).hasMatch(email);
  }

  bool _isValidPassword(String password) {
    String passwordPattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    return RegExp(passwordPattern).hasMatch(password);
  }

  void showSnackbar(String title, String message, Color color) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: Colors.white,
    );
  }
}
