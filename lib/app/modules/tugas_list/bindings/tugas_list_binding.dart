import 'package:get/get.dart';

import '../controllers/tugas_list_controller.dart';

class TugasListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TugasListController>(
      () => TugasListController(),
    );
  }
}
