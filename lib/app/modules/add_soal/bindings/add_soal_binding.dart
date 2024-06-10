import 'package:get/get.dart';

import '../controllers/add_soal_controller.dart';

class AddSoalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSoalController>(
      () => AddSoalController(),
    );
  }
}
