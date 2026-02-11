import 'package:get/get.dart';

import '../controllers/infokos_controller.dart';

class InfokosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfokosController>(
      () => InfokosController(),
    );
  }
}
