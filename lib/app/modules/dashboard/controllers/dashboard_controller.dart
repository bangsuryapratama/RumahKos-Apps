import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController {

  final box = GetStorage();
  /// LOADING
  var isLoading = true.obs;

  /// USER
  var name = ''.obs;

  /// ROOM
  var roomNumber = ''.obs;
  var roomStatus = ''.obs;
  var roomDetail = ''.obs;

  /// BILL
  var billTitle = ''.obs;
  var billAmount = 0.obs;
  var billDueDate = ''.obs;
  var isPaid = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  /// ================= FETCH API =================
  Future<void> fetchDashboard() async {
  try {
    isLoading.value = true;

    final user = box.read('user');

    if (user != null) {
      name.value = user['name'] ?? '';
    }

    // ====== contoh ambil data lain dari API ======
    await Future.delayed(const Duration(seconds: 1));

    roomNumber.value = "A-12";
    roomStatus.value = "Aktif";
    roomDetail.value = "Lantai 2 • AC • KM Dalam";

    billTitle.value = "Sewa Februari 2026";
    billAmount.value = 1200000;
    billDueDate.value = "28 Feb 2026";
    isPaid.value = false;

  } catch (e) {
    Get.snackbar("Error", "Gagal memuat dashboard");
  } finally {
    isLoading.value = false;
  }
}

  /// ================= ACTION =================
  void payBill() {
    isPaid.value = true;

    Get.snackbar(
      "Berhasil",
      "Pembayaran berhasil dilakukan",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
