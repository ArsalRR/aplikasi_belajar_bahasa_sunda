import 'package:get/get.dart';

import '../controllers/bhs_sunda_controller.dart';

class BhsSundaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BhsSundaController>(
      () => BhsSundaController(),
    );
  }
}
