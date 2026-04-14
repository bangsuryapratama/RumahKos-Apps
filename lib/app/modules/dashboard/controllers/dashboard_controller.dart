import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import 'package:rumahkosapps/app/utils/api.dart';

class DashboardController extends GetxController {
  final box = GetStorage();

  var isLoading = true.obs;

  var name = ''.obs;

  var roomName = ''.obs;
  var property = ''.obs;
  var hasKos = false.obs;

  var pendingCount = 0.obs;
  var overdueCount = 0.obs;
  var totalOverdue = 0.obs;

  var payments = [].obs;

  Future<void> fetchDashboard() async {
    try {
      isLoading.value = true;

      final token = box.read('token');

      final res = await Dio().get(
        Api.dashboard,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );

      final data = res.data['data'];

      name.value = data['user']['name'] ?? '-';

      if (data['room'] != null) {
        hasKos.value = true;
        roomName.value = data['room']['name'] ?? '-';
        property.value = data['room']['property'] ?? '-';
      } else {
        hasKos.value = false;
      }

      final billing = data['billing'];

      pendingCount.value = billing['pending_count'] ?? 0;
      overdueCount.value = billing['overdue_count'] ?? 0;
      totalOverdue.value = billing['total_overdue'] ?? 0;

      payments.value = data['payments'] ?? [];

    } catch (e) {
      Get.snackbar("Error", "Gagal load dashboard");
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchDashboard();
    super.onInit();
  }
}