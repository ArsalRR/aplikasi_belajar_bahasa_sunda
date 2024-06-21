import 'package:get/get.dart';

import '../controllers/edit_tugas_controller.dart';

class EditTugasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditTugasController>(
      () => EditTugasController(),
    );
  }
}
