import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../utils/api.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  final box = GetStorage();

  static const primaryColor = Color(0xFF2563EB);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    clientId: '121604383728-3c0fmrf6i6tv6mm3f2nupoenj5751in7.apps.googleusercontent.com',
  );

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLogin = true.obs;
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var agreeToTerms = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeGoogleSignIn();
  }

  Future<void> _initializeGoogleSignIn() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint('Google SignIn init error: ${e.toString()}');
    }
  }

  void toggleAuthMode() {
    isLogin.toggle();
    _clearControllers();
    isPasswordVisible.value = false;
    isConfirmPasswordVisible.value = false;
    agreeToTerms.value = false;
  }

  void _clearControllers() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    confirmPasswordController.clear();
  }

  Map<String, String> get _headers => {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "ngrok-skip-browser-warning": "true",
  };

  // ================= AUTH =================
  Future<void> login() async {
    if (!_validateLoginForm()) return;

    _executeAuth(() => http.post(
      Uri.parse(Api.login),
      headers: _headers,
      body: jsonEncode({
        "email": emailController.text.trim(),
        "password": passwordController.text,
      }),
    ));
  }

  Future<void> register() async {
    if (!_validateRegisterForm()) return;

    _executeAuth(() => http.post(
      Uri.parse(Api.register),
      headers: _headers,
      body: jsonEncode({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
      }),
    ), isRegister: true);
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      await _googleSignIn.signOut();

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      final googleAuth = await googleUser.authentication;

      debugPrint('Google SignIn Success: ${googleUser.email}');

      // Kirim ke backend
      final response = await http.post(
        Uri.parse(Api.socialLogin),
        headers: _headers,
        body: jsonEncode({
          "provider": "google",
          "provider_id": googleUser.id,
          "email": googleUser.email,
          "name": googleUser.displayName ?? googleUser.email.split('@')[0],
          "avatar": googleUser.photoUrl,
          "access_token": googleAuth.accessToken,
        }),
      );

      _handleResponse(response);

    } catch (e) {
      isLoading.value = false;
      _showErrorSnackbar("Gagal masuk dengan Google");
      debugPrint('GoogleSignIn Error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _executeAuth(Future<http.Response> Function() call, {bool isRegister = false}) async {
    try {
      isLoading.value = true;
      final response = await call();
      _handleResponse(response, isRegister: isRegister);
    } catch (e) {
      _showErrorSnackbar("Cek koneksi internet");
      debugPrint('Auth error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleResponse(http.Response response, {bool isRegister = false}) {
    try {
      final data = jsonDecode(response.body);

      if ((isRegister && response.statusCode == 201) || (!isRegister && response.statusCode == 200)) {
        box.write("token", data["data"]["token"]);
        box.write("user", data["data"]["user"]);

        _showSuccessSnackbar(data["message"] ?? (isRegister ? "Registrasi berhasil!" : "Login berhasil!"));

        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offAllNamed(Routes.MAIN_NAV);
        });
      } else {
        String errorMsg = data["message"] ?? "Terjadi kesalahan";
        if (data["errors"] != null && data["errors"] is Map) {
          final errors = data["errors"] as Map;
          errorMsg = errors.values.first is List ? errors.values.first[0] : errors.values.first.toString();
        }
        _showErrorSnackbar(errorMsg);
      }
    } catch (e) {
      _showErrorSnackbar("Terjadi kesalahan response");
      debugPrint('Response parse error: ${e.toString()}');
    }
  }

  // ================= SNACKBARS =================
void _showSuccessSnackbar(String message) {
  Get.snackbar(
    "Sukses", // title wajib di beberapa versi GetX
    "",
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.green.withOpacity(0.2),
    snackPosition: SnackPosition.BOTTOM,
  );
}

void _showErrorSnackbar(String message) {
  Get.snackbar(
    "Error", // title wajib di beberapa versi GetX
    "",
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ),
    backgroundColor: Colors.red.withOpacity(0.2),
    snackPosition: SnackPosition.BOTTOM,
  );
}


  // ================= VALIDATION =================
  bool _validateLoginForm() {
    if (emailController.text.trim().isEmpty) return false;
    if (!GetUtils.isEmail(emailController.text.trim())) return false;
    if (passwordController.text.isEmpty) return false;
    return true;
  }

  bool _validateRegisterForm() {
    if (nameController.text.trim().isEmpty) return false;
    if (emailController.text.trim().isEmpty) return false;
    if (!GetUtils.isEmail(emailController.text.trim())) return false;
    if (passwordController.text.length < 8) return false;
    if (passwordController.text != confirmPasswordController.text) return false;
    if (!agreeToTerms.value) return false;
    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
