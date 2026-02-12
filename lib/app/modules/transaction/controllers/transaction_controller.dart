import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utils/api.dart';

class TransactionController extends GetxController {
  final Dio _dio = Dio();
  final box = GetStorage();

  // ─── State ───────────────────────────────────────────────
  var isLoading = false.obs;
  var isPayLoading = false.obs;       // loading per-payment (bayar)
  var isCheckLoading = false.obs;
  var activePayingId = RxnInt();
  var activeCheckId = RxnInt();

  var payments = <Map<String, dynamic>>[].obs;
  var filteredPayments = <Map<String, dynamic>>[].obs;

  // ─── Filter & sort ───────────────────────────────────────
  // status: 'all' | 'pending' | 'paid' | 'failed'
  var selectedFilter = 'all'.obs;

  final List<Map<String, String>> filterOptions = [
    {'key': 'all',     'label': 'Semua'},
    {'key': 'pending', 'label': 'Belum Bayar'},
    {'key': 'paid',    'label': 'Lunas'},
    {'key': 'failed',  'label': 'Gagal'},
  ];

  // ─── Summary stats (derived) ─────────────────────────────
  int get totalTransactions => payments.length;
  int get unpaidCount =>
      payments.where((p) => p['status'] == 'pending').length;
  int get totalPaidAmount => payments
      .where((p) => p['status'] == 'paid')
      .fold(0, (sum, p) => sum + ((p['amount'] as num?)?.toInt() ?? 0));

  // ─────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _setupDio();
    fetchPayments();

    // Otomatis filter ulang kalau selectedFilter berubah
    ever(selectedFilter, (_) => _applyFilter());
    ever(payments, (_) => _applyFilter());
  }

  // ─── Dio Setup ───────────────────────────────────────────
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
        options.headers['ngrok-skip-browser-warning'] = 'true';
        return handler.next(options);
      },
    ));
  }

  // ─── FETCH PAYMENTS ──────────────────────────────────────
  Future<void> fetchPayments() async {
    try {
      isLoading(true);

      final response = await _dio.get(Api.paymentHistory);

      if (response.data['success'] == true) {
        payments.value =
            List<Map<String, dynamic>>.from(response.data['data']);
      } else {
        _showError(response.data['message'] ?? 'Gagal mengambil data');
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _showError('Terjadi kesalahan tidak terduga');
    } finally {
      isLoading(false);
    }
  }

  Future<void> refreshData() async => fetchPayments();

  // ─── BAYAR via Midtrans Snap ─────────────────────────────
  /// Ambil snap_token dari backend lalu buka Midtrans Snap webview / bottom sheet.
  /// Untuk Flutter, kita gunakan webview_flutter atau url_launcher.
  /// Di sini kita kembalikan snap_token + order_id ke View supaya View
  /// bisa membuka MidtransWebview atau meneruskan ke package midtrans_snap.
  Future<void> payWithMidtrans(int paymentId) async {
    try {
      activePayingId.value = paymentId;
      isPayLoading(true);

      final response =
          await _dio.post(Api.createSnap(paymentId));

      if (response.data['success'] == true) {
        final snapToken = response.data['snap_token'] as String;
        final orderId   = response.data['order_id']   as String;

        // Navigasi ke halaman webview pembayaran
        final result = await Get.toNamed(
          '/payment/webview',
          arguments: {
            'snap_token': snapToken,
            'order_id':   orderId,
            'payment_id': paymentId,
          },
        );

        // Setelah kembali dari webview, cek status pembayaran
        if (result != null) {
          await checkPaymentStatus(paymentId, showSnackbar: true);
        } else {
          // User close webview tanpa transaksi — cek diam-diam
          await checkPaymentStatus(paymentId, showSnackbar: false);
        }
      } else {
        _showError(response.data['message'] ?? 'Gagal membuat pembayaran');
      }
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      _showError('Terjadi kesalahan tidak terduga');
    } finally {
      isPayLoading(false);
      activePayingId.value = null;
    }
  }

  // ─── CHECK STATUS ─────────────────────────────────────────
  Future<void> checkPaymentStatus(int paymentId,
      {bool showSnackbar = true}) async {
    try {
      activeCheckId.value = paymentId;
      isCheckLoading(true);

      final response =
          await _dio.get(Api.checkStatus(paymentId));

      if (response.data['success'] == true) {
        final updated =
            Map<String, dynamic>.from(response.data['data']);

        // Update data lokal tanpa re-fetch semua
        final idx = payments.indexWhere((p) => p['id'] == paymentId);
        if (idx != -1) {
          payments[idx] = updated;
          payments.refresh();
        }

        if (showSnackbar) {
          final status = updated['status'] ?? '';
          if (status == 'paid') {
            _showSuccess('Pembayaran berhasil! ✓');
          } else if (status == 'pending') {
            _showInfo('Menunggu konfirmasi pembayaran');
          } else {
            _showError('Pembayaran gagal atau dibatalkan');
          }
        }
      } else {
        if (showSnackbar) {
          _showError(response.data['message'] ?? 'Gagal memeriksa status');
        }
      }
    } on DioException catch (e) {
      if (showSnackbar) _handleDioError(e);
    } catch (e) {
      if (showSnackbar) _showError('Terjadi kesalahan');
    } finally {
      isCheckLoading(false);
      activeCheckId.value = null;
    }
  }

  // ─── FILTER ───────────────────────────────────────────────
  void setFilter(String key) => selectedFilter.value = key;

  void _applyFilter() {
    if (selectedFilter.value == 'all') {
      filteredPayments.value = List.from(payments);
    } else {
      filteredPayments.value = payments
          .where((p) =>
              (p['status'] as String?)?.toLowerCase() ==
              selectedFilter.value)
          .toList();
    }
  }

  // ─── HELPERS ─────────────────────────────────────────────
  String formatPrice(dynamic price) {
    final val = (price as num?)?.toInt() ?? 0;
    return 'Rp ${val.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]}.',
    )}';
  }

  /// Cek apakah payment sedang dalam proses bayar
  bool isPayingThis(int id) =>
      isPayLoading.value && activePayingId.value == id;

  /// Cek apakah payment sedang dicek statusnya
  bool isCheckingThis(int id) =>
      isCheckLoading.value && activeCheckId.value == id;

  /// Status yang bisa dibayar
  bool canPay(Map<String, dynamic> payment) {
    final status = (payment['status'] as String?)?.toLowerCase();
    return status == 'pending' || status == 'failed';
  }

  void _showError(String msg) {
    Get.snackbar(
      'Gagal',
      msg,
      backgroundColor: const Color(0xFFEF4444),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  void _showSuccess(String msg) {
    Get.snackbar(
      'Berhasil',
      msg,
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  void _showInfo(String msg) {
    Get.snackbar(
      'Info',
      msg,
      backgroundColor: const Color(0xFFF59E0B),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  void _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      _showError('Koneksi timeout. Periksa internet Anda');
    } else if (e.response?.statusCode == 401) {
      _showError('Sesi habis, silakan login ulang');
      Get.offAllNamed('/login');
    } else if (e.response?.statusCode == 404) {
      _showError('Data tidak ditemukan');
    } else if (e.response?.statusCode == 400) {
      final msg = e.response?.data?['message'] ?? 'Permintaan tidak valid';
      _showError(msg);
    } else if (e.response?.statusCode == 500) {
      _showError('Server error. Coba lagi nanti');
    } else {
      _showError('Tidak dapat terhubung ke server');
    }
  }
}
