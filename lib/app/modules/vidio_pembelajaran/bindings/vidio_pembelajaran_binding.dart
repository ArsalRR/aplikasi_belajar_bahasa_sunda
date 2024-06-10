import 'package:get/get.dart';

import '../controllers/vidio_pembelajaran_controller.dart';

class VidioPembelajaranBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VidioPembelajaranController>(
      () => VidioPembelajaranController(),
    );
  }
}
