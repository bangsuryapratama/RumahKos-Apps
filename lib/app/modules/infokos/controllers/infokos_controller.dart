import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rumahkosapps/app/utils/api.dart';
// import '../utils/api.dart';

class InfokosController extends GetxController {
  final Dio _dio = Dio();
  final box = GetStorage();

  // ==================
  // OBSERVABLES
  // ==================
  var isLoading = false.obs;
  var hasResidence = false.obs;

  // Residence Data
  var residenceId = 0.obs;
  var startDate = ''.obs;
  var endDate = ''.obs;
  var residenceStatus = ''.obs;
  var durationMonths = 0.obs;
  var isContractActive = false.obs;

  // Room Data
  var roomId = 0.obs;
  var roomName = ''.obs;
  var roomFloor = 0.obs;
  var roomSize = ''.obs;
  var roomPrice = 0.obs;
  var roomBillingCycle = ''.obs;
  var roomImage = ''.obs;
  var roomStatus = ''.obs;

  // Property Data
  var propertyId = 0.obs;
  var propertyName = ''.obs;
  var propertyAddress = ''.obs;
  var propertyDescription = ''.obs;

  // Facilities
  var facilities = <Map<String, dynamic>>[].obs;

  // Statistics
  var unpaidPayments = 0.obs;
  var totalPayments = 0.obs;

  // Recent Payments
  var recentPayments = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _setupDio();
    fetchCurrentResidence();
  }

  // Setup Dio with interceptor
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
          // Navigate to login if needed
        }
        return handler.next(error);
      },
    ));
  }

  // ==================
  // FETCH CURRENT RESIDENCE
  // ==================
  Future<void> fetchCurrentResidence() async {
    try {
      isLoading.value = true;

      final response = await _dio.get(Api.currentResidence);

      if (response.data['success'] == true) {
        final data = response.data['data'];

        if (data == null) {
          hasResidence.value = false;
          _showInfoSnackbar('Anda belum terdaftar sebagai penghuni');
        } else {
          hasResidence.value = true;
          _parseResidenceData(data);
        }
      } else {
        _showErrorSnackbar(response.data['message'] ?? 'Gagal memuat data');
      }
    } catch (e) {
      _showErrorSnackbar(_handleError(e));
    } finally {
      isLoading.value = false;
    }
  }

  // ==================
  // PARSE RESIDENCE DATA
  // ==================
  void _parseResidenceData(Map<String, dynamic> data) {
    // Resident data
    final resident = data['resident'] ?? {};
    residenceId.value = resident['id'] ?? 0;
    startDate.value = resident['start_date'] ?? '';
    endDate.value = resident['end_date'] ?? '';
    residenceStatus.value = resident['status'] ?? '';
    durationMonths.value = resident['duration_months'] ?? 0;
    isContractActive.value = resident['is_contract_active'] ?? false;

    // Room data
    final room = data['room'] ?? {};
    roomId.value = room['id'] ?? 0;
    roomName.value = room['name'] ?? '';
    roomFloor.value = room['floor'] ?? 0;
    roomSize.value = room['size'] ?? '';
    roomPrice.value = room['price'] ?? 0;
    roomBillingCycle.value = room['billing_cycle'] ?? '';
    roomImage.value = room['image'] ?? '';
    roomStatus.value = room['status'] ?? '';

    // Property data
    final property = data['property'] ?? {};
    propertyId.value = property['id'] ?? 0;
    propertyName.value = property['name'] ?? '';
    propertyAddress.value = property['address'] ?? '';
    propertyDescription.value = property['description'] ?? '';

    // Facilities
    facilities.value = List<Map<String, dynamic>>.from(data['facilities'] ?? []);

    // Statistics
    final stats = data['statistics'] ?? {};
    unpaidPayments.value = stats['unpaid_payments'] ?? 0;
    totalPayments.value = stats['total_payments'] ?? 0;

    // Recent payments
    recentPayments.value = List<Map<String, dynamic>>.from(data['recent_payments'] ?? []);
  }

  // ==================
  // REFRESH DATA
  // ==================
  Future<void> refreshData() async {
    await fetchCurrentResidence();
  }

  // ==================
  // HELPERS
  // ==================
  String formatPrice(int price) {
    return 'Rp ${price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.'
    )}';
  }

  String formatDate(String date) {
    if (date.isEmpty) return '-';
    try {
      final DateTime dt = DateTime.parse(date);
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
    } catch (e) {
      return date;
    }
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
      duration: const Duration(seconds: 2),
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

  void _showInfoSnackbar(String message) {
    Get.snackbar(
      '', '',
      titleText: const SizedBox.shrink(),
      messageText: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2563EB).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.info_rounded, color: Color(0xFF2563EB), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Color(0xFF1E40AF),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFFDEEBFF),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }
}
