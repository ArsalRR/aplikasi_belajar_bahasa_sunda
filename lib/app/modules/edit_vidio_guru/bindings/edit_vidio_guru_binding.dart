import 'package:get/get.dart';

import '../controllers/edit_vidio_guru_controller.dart';

class EditVidioGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditVidioGuruController>(
      () => EditVidioGuruController(),
    );
  }
}
