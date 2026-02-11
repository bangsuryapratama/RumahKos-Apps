import 'package:get/get.dart';
import 'package:rumahkosapps/app/modules/dashboard/views/dashboard_view.dart';
import 'package:rumahkosapps/app/modules/infokos/views/infokos_view.dart';
import 'package:rumahkosapps/app/modules/profile/controllers/profile_controller.dart';
import 'package:rumahkosapps/app/modules/profile/views/profile_view.dart';
import 'package:rumahkosapps/app/modules/transaction/views/transaction_view.dart';

class MainNavController extends GetxController {
  var selectedIndex = 0.obs;
  final ProfileController profileController = Get.put(ProfileController());

  final pages = [
    const DashboardView(),
    InfokosView(),
    TransactionView(),
    ProfileView(),
  ];

  void changeTab(int index){
    selectedIndex.value = index;
  }
}
