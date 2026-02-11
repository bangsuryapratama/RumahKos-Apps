import 'package:get/get.dart';
import '../controllers/main_nav_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class MainNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavController>(() => MainNavController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
