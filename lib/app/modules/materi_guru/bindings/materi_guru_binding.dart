import 'package:get/get.dart';

import '../controllers/materi_guru_controller.dart';

class MateriGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MateriGuruController>(
      () => MateriGuruController(),
    );
  }
}
