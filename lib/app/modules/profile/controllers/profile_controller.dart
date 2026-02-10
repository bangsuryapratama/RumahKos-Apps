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
      Get.snackbar(
        'Error',
        'Failed to load user data',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void refreshUserData() {
    _loadUserData();
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // Close dialog
              isLoading.value = true;

              // Show loading
              Get.dialog(
                const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                barrierDismissible: false,
              );

              // Simulate logout delay
              await Future.delayed(const Duration(seconds: 1));

              // Clear storage
              box.erase();

              isLoading.value = false;
              Get.back(); // Close loading

              // Navigate to auth
              Get.offAllNamed(Routes.AUTH);

              // Show success message
              Get.snackbar(
                'Success',
                'You have been logged out',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                borderRadius: 8,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
