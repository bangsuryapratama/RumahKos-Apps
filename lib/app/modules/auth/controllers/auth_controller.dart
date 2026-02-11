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

  // Primary Color - Blue
  static const primaryColor = Color(0xFF2563EB);

  // Initialize GoogleSignIn dengan proper config
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId: 'Y121604383728-3c0fmrf6i6tv6mm3f2nupoenj5751in7.apps.googleusercontent.com',
  );

  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  // final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable states
  var isLogin = true.obs;
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var agreeToTerms = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize Google Sign In saat controller dibuat
    _initializeGoogleSignIn();
  }

  // Initialize Google Sign In
  Future<void> _initializeGoogleSignIn() async {
    try {
      // Coba sign out terlebih dahulu untuk clear state
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint('Google Sign In initialization: ${e.toString()}');
    }
  }

  // Fungsi Switch Mode
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
    // phoneController.clear();
    confirmPasswordController.clear();
  }

  // Header Standar (Ngrok Support)
  Map<String, String> get _headers => {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "ngrok-skip-browser-warning": "true",
  };

  // ================= AUTH METHODS =================

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

    _executeAuth(
      () => http.post(
        Uri.parse(Api.register),
        headers: _headers,
        body: jsonEncode({
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "password": passwordController.text,
          "password_confirmation": confirmPasswordController.text,
          // "phone": phoneController.text.trim(),
        }),
      ),
      isRegister: true,
    );
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;

      // Sign out terlebih dahulu untuk memastikan user memilih akun
      await _googleSignIn.signOut();

      // Tampilkan dialog pemilihan akun Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // User membatalkan login
      if (googleUser == null) {
        isLoading.value = false;
        return;
      }

      // Get authentication
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      debugPrint('Google Sign In Success: ${googleUser.email}');

      // Kirim data ke backend
      final response = await http.post(
        Uri.parse(Api.socialLogin),
        headers: _headers,
        body: jsonEncode({
          "provider": "google",
          "provider_id": googleUser.id,
          "email": googleUser.email,
          "name": googleUser.displayName ?? googleUser.email.split('@')[0],
          "avatar": googleUser.photoUrl,
        }),
      );

      _handleResponse(response);

    } on Exception catch (e) {
      isLoading.value = false;

      String errorMessage = 'Gagal masuk dengan Google';

      // Handle specific errors
      if (e.toString().contains('sign_in_canceled')) {
        return; // User canceled, no need to show error
      } else if (e.toString().contains('network_error')) {
        errorMessage = 'Tidak ada koneksi internet';
      } else if (e.toString().contains('sign_in_failed')) {
        errorMessage = 'Login Google gagal. Coba lagi';
      }

      _showErrorSnackbar(errorMessage);

      debugPrint('Google Sign In Error: ${e.toString()}');
    } finally {
      if (isLoading.value) {
        isLoading.value = false;
      }
    }
  }

  // ================= HELPERS =================

  Future<void> _executeAuth(
    Future<http.Response> Function() call, {
    bool isRegister = false,
  }) async {
    try {
      isLoading.value = true;
      final response = await call();
      _handleResponse(response, isRegister: isRegister);
    } catch (e) {
      _showErrorSnackbar("Koneksi gagal. Periksa internet Anda");
      debugPrint('Auth Error: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void _handleResponse(http.Response response, {bool isRegister = false}) {
    try {
      final data = jsonDecode(response.body);

      if ((isRegister && response.statusCode == 201) ||
          (!isRegister && response.statusCode == 200)) {
        // Success
        box.write("token", data["data"]["token"]);
        box.write("user", data["data"]["user"]);

        _showSuccessSnackbar(
          data["message"] ?? (isRegister ? "Registrasi berhasil!" : "Login berhasil!"),
        );

        Future.delayed(const Duration(milliseconds: 500), () {
          Get.offAllNamed(Routes.MAIN_NAV);
        });
      } else {
        // Error
        String errorMsg = data["message"] ?? "Terjadi kesalahan";

        if (data["errors"] != null && data["errors"] is Map) {
          final errors = data["errors"] as Map;
          errorMsg = errors.values.first is List
              ? errors.values.first[0]
              : errors.values.first.toString();
        }

        _showErrorSnackbar(errorMsg);
      }
    } catch (e) {
      _showErrorSnackbar("Terjadi kesalahan saat memproses response");
      debugPrint('Response parsing error: ${e.toString()}');
    }
  }

  // ================= MODERN NOTIFICATION SYSTEM =================

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      "",
      "",
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF10B981),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF065F46),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFD1FAE5),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "",
      "",
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.error_rounded,
              color: Color(0xFFEF4444),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF991B1B),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFFEE2E2),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  void _showWarningSnackbar(String message) {
    Get.snackbar(
      "",
      "",
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: Color(0xFFF59E0B),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF92400E),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFFEF3C7),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  void _showInfoSnackbar(String message) {
    Get.snackbar(
      "",
      "",
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.info_rounded,
              color: primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF1E3A8A),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFDBEAFE),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 3),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }

  // ================= VALIDATION METHODS =================

  bool _validateLoginForm() {
    if (emailController.text.trim().isEmpty) {
      _showWarningSnackbar("Email wajib diisi");
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      _showWarningSnackbar("Format email tidak valid");
      return false;
    }

    if (passwordController.text.isEmpty) {
      _showWarningSnackbar("Password wajib diisi");
      return false;
    }

    return true;
  }

  bool _validateRegisterForm() {
    if (nameController.text.trim().isEmpty) {
      _showWarningSnackbar("Nama lengkap wajib diisi");
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      _showWarningSnackbar("Email wajib diisi");
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      _showWarningSnackbar("Format email tidak valid");
      return false;
    }

    // if (phoneController.text.trim().isEmpty) {
    //   _showWarningSnackbar("Nomor telepon wajib diisi");
    //   return false;
    // }

    if (passwordController.text.length < 8) {
      _showWarningSnackbar("Password minimal 8 karakter");
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showWarningSnackbar("Konfirmasi password tidak cocok");
      return false;
    }

    if (!agreeToTerms.value) {
      _showInfoSnackbar("Anda harus menyetujui Syarat & Ketentuan");
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    // phoneController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
