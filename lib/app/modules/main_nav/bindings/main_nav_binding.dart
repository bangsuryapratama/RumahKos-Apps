import 'package:get/get.dart';
import 'package:rumahkosapps/app/modules/infokos/controllers/infokos_controller.dart';
import 'package:rumahkosapps/app/modules/transaction/controllers/transaction_controller.dart';
import '../controllers/main_nav_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class MainNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainNavController>(() => MainNavController());
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<InfokosController>(()=> InfokosController());
    Get.lazyPut<TransactionController>(() => TransactionController());
  }
}
