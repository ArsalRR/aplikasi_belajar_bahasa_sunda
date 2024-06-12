import 'package:get/get.dart';

import '../controllers/update_materi_vidio_guru_controller.dart';

class UpdateMateriVidioGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateMateriVidioGuruController>(
      () => UpdateMateriVidioGuruController(),
    );
  }
}
