import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rumahkosapps/app/routes/app_pages.dart';
import 'package:rumahkosapps/app/utils/api.dart';
import 'package:dio/dio.dart' as dio;
// import '../utils/api.dart';
// import '../routes/app_pages.dart';

class ProfileController extends GetxController {
  final Dio _dio = Dio();
  final box = GetStorage();
  final ImagePicker _picker = ImagePicker();

  // ==================
  // OBSERVABLES
  // ==================
  var isLoading = false.obs;

  // User Data
  var userId = 0.obs;
  var name = ''.obs;
  var email = ''.obs;
  var avatar = ''.obs;
  var role = ''.obs;
  var createdAt = ''.obs;

  // Profile Data
  var phone = ''.obs;
  var identityNumber = ''.obs;
  var address = ''.obs;
  var dateOfBirth = ''.obs;
  var gender = ''.obs;
  var occupation = ''.obs;
  var emergencyContact = ''.obs;
  var emergencyContactName = ''.obs;

  // Documents
  var ktpPhoto = ''.obs;
  var simPhoto = ''.obs;
  var passportPhoto = ''.obs;

  // Stats
  var completionPercent = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _setupDio();
    _loadUserDataFromStorage();
    fetchProfile();
  }

  // Setup Dio
  void _setupDio() {
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = box.read('token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        options.headers['Accept'] = 'application/json';
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          box.erase();
          Get.offAllNamed(Routes.AUTH);
        }
        return handler.next(error);
      },
    ));
  }

  // Load basic user data from storage
  void _loadUserDataFromStorage() {
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

  // ==================
  // FETCH PROFILE
  // ==================
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final response = await _dio.get(Api.profile);

      if (response.data['success'] == true) {
        final data = response.data['data'];
        _parseProfileData(data);

        // Update storage
        box.write('user', {
          'name': name.value,
          'email': email.value,
          'phone': phone.value,
          'role': role.value,
        });
      } else {
        _showErrorSnackbar(response.data['message'] ?? 'Gagal memuat profile');
      }
    } catch (e) {
      _showErrorSnackbar(_handleError(e));
    } finally {
      isLoading.value = false;
    }
  }

  // ==================
  // PARSE PROFILE DATA
  // ==================
  void _parseProfileData(Map<String, dynamic> data) {
    // User data
    final user = data['user'] ?? {};
    userId.value = user['id'] ?? 0;
    name.value = user['name'] ?? '';
    email.value = user['email'] ?? '';
    avatar.value = user['avatar'] ?? '';
    role.value = user['role'] ?? 'tenant';
    createdAt.value = user['created_at'] ?? '';

    // Profile data
    final profile = data['profile'];
    if (profile != null) {
      phone.value = profile['phone'] ?? '';
      identityNumber.value = profile['identity_number'] ?? '';
      address.value = profile['address'] ?? '';
      dateOfBirth.value = profile['date_of_birth'] ?? '';
      gender.value = profile['gender'] ?? '';
      occupation.value = profile['occupation'] ?? '';
      emergencyContact.value = profile['emergency_contact'] ?? '';
      emergencyContactName.value = profile['emergency_contact_name'] ?? '';

      ktpPhoto.value = profile['ktp_photo'] ?? '';
      simPhoto.value = profile['sim_photo'] ?? '';
      passportPhoto.value = profile['passport_photo'] ?? '';
    }

    completionPercent.value = data['completion_percent'] ?? 0;
  }

  // ==================
  // UPDATE PROFILE
  // ==================
  Future<void> updateProfile(Map<String, dynamic> profileData) async {
    try {
      isLoading.value = true;

      final response = await _dio.put(Api.updateProfile, data: profileData);

      if (response.data['success'] == true) {
        _showSuccessSnackbar('Profile berhasil diperbarui');
        await fetchProfile();
      } else {
        _showErrorSnackbar(response.data['message'] ?? 'Gagal memperbarui profile');
      }
    } catch (e) {
      _showErrorSnackbar(_handleError(e));
    } finally {
      isLoading.value = false;
    }
  }

  // ==================
  // UPLOAD DOCUMENT
  // ==================
  Future<void> uploadDocument(String documentType) async {
    try {
      // Pick image
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1920,
      );

      if (image == null) return;

      isLoading.value = true;

      dio.FormData formData = dio.FormData.fromMap({
        'document_type': documentType,
        'document': await dio.MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      final response = await _dio.post(Api.uploadDocument, data: formData);

      if (response.data['success'] == true) {
        _showSuccessSnackbar('Dokumen berhasil diupload');
        await fetchProfile();
      } else {
        _showErrorSnackbar(response.data['message'] ?? 'Gagal mengupload dokumen');
      }
    } catch (e) {
      _showErrorSnackbar(_handleError(e));
    } finally {
      isLoading.value = false;
    }
  }

  // ==================
  // DELETE DOCUMENT
  // ==================
  Future<void> deleteDocument(String documentType) async {
    try {
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text("Konfirmasi Hapus", style: TextStyle(fontWeight: FontWeight.w900)),
          content: const Text("Apakah Anda yakin ingin menghapus dokumen ini?"),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text("Batal", style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () => Get.back(result: true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Hapus", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      );

      if (confirmed != true) return;

      isLoading.value = true;

      final response = await _dio.delete(
        Api.deleteDocument,
        data: {'document_type': documentType},
      );

      if (response.data['success'] == true) {
        _showSuccessSnackbar('Dokumen berhasil dihapus');
        await fetchProfile();
      } else {
        _showErrorSnackbar(response.data['message'] ?? 'Gagal menghapus dokumen');
      }
    } catch (e) {
      _showErrorSnackbar(_handleError(e));
    } finally {
      isLoading.value = false;
    }
  }

  // ==================
  // LOGOUT
  // ==================
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

    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Color(0xFF2563EB))),
      barrierDismissible: false,
    );

    await Future.delayed(const Duration(seconds: 1));
    box.erase();

    isLoading.value = false;
    Get.back();

    Get.offAllNamed(Routes.AUTH);
    _showSuccessSnackbar('Berhasil keluar. Sampai jumpa kembali!');
  }

  // ==================
  // ERROR HANDLER
  // ==================
  String _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Koneksi timeout. Periksa internet Anda.';
        case DioExceptionType.badResponse:
          final message = error.response?.data['message'];
          return message ?? 'Terjadi kesalahan';
        case DioExceptionType.cancel:
          return 'Request dibatalkan';
        default:
          return 'Tidak dapat terhubung ke server';
      }
    }
    return error.toString();
  }

  // ==================
  // SNACKBAR HELPERS
  // ==================
  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      '', '',
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
      duration: const Duration(seconds: 3),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      '', '',
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
      duration: const Duration(seconds: 3),
    );
  }
}
