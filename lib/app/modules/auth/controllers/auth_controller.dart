import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../utils/api.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final box = GetStorage();

  // ================= TEXT CONTROLLERS =================
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ================= STATE =================
  var isLogin = true.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isLoading = false.obs;
  var agreeToTerms = false.obs;

  void toggleAuthMode() => isLogin.toggle();
  void togglePasswordVisibility() => isPasswordVisible.toggle();
  void toggleConfirmPasswordVisibility() => isConfirmPasswordVisible.toggle();

  // ================= LOGIN =================
  Future<void> login() async {
    if (!_validateLoginForm()) return;

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(Api.login),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        box.write("token", data["data"]["token"]);
        box.write("user", data["data"]["user"]);

        Get.snackbar("Success", data["message"]);
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        Get.snackbar("Login Gagal", data["message"]);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ================= REGISTER =================
  Future<void> register() async {
    if (!_validateRegisterForm()) return;

    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse(Api.register),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "password_confirmation": confirmPasswordController.text,
          "phone": phoneController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        box.write("token", data["data"]["token"]);
        box.write("user", data["data"]["user"]);

        Get.snackbar("Berhasil", data["message"]);
        Get.offAllNamed(Routes.DASHBOARD);
      } else {
        Get.snackbar("Register Gagal", data["message"]);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ================= VALIDATION =================
  bool _validateLoginForm() {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Error", "Email tidak valid");
      return false;
    }
    if (passwordController.text.isEmpty) {
      Get.snackbar("Error", "Password tidak boleh kosong");
      return false;
    }
    return true;
  }

  bool _validateRegisterForm() {
    if (nameController.text.isEmpty) {
      Get.snackbar("Error", "Nama tidak boleh kosong");
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Error", "Format email tidak valid");
      return false;
    }
    if (passwordController.text.length < 8) {
      Get.snackbar("Error", "Password minimal 8 karakter");
      return false;
    }
    if (confirmPasswordController.text != passwordController.text) {
      Get.snackbar("Error", "Password tidak cocok");
      return false;
    }
    if (!agreeToTerms.value) {
      Get.snackbar("Error", "Setujui syarat & ketentuan");
      return false;
    }
    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
