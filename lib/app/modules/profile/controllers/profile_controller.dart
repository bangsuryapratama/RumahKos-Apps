import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rumahkosapps/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var role = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
  }

  void _loadUserData() {
    try {
      final user = box.read('user');
      if (user != null) {
        name.value = user['name'] ?? '';
        email.value = user['email'] ?? '';
        phone.value = user['phone'] ?? '';
        role.value = user['role'] ?? 'tenant';
      }
    } catch (e) {
      _showErrorSnackbar('Gagal memuat data pengguna');
    }
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text("Konfirmasi Keluar", style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text("Apakah Anda yakin ingin keluar dari aplikasi RumahKos?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Batal", style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              _processLogout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text("Ya, Keluar", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> _processLogout() async {
    isLoading.value = true;

    // Loading overlay modern
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Color(0xFF2563EB))),
      barrierDismissible: false,
    );

    await Future.delayed(const Duration(seconds: 1));
    box.erase();

    isLoading.value = false;
    Get.back(); // Tutup loading

    Get.offAllNamed(Routes.AUTH);
    _showSuccessSnackbar('Berhasil keluar. Sampai jumpa kembali!');
  }

  // === PREMIUM SNACKBAR SYSTEM (KONSISTEN DENGAN AUTH) ===

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      "", "",
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: const TextStyle(color: Color(0xFF065F46), fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFD1FAE5),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "", "",
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.error_rounded, color: Color(0xFFEF4444), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: const TextStyle(color: Color(0xFF991B1B), fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFFEE2E2),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }
}
