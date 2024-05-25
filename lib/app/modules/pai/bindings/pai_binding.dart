import 'package:get/get.dart';

import '../controllers/pai_controller.dart';

class PaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaiController>(
      () => PaiController(),
    );
  }
}
