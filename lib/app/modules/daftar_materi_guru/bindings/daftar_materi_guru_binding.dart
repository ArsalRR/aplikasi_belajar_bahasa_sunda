import 'package:get/get.dart';

import '../controllers/daftar_materi_guru_controller.dart';

class DaftarMateriGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarMateriGuruController>(
      () => DaftarMateriGuruController(),
    );
  }
}
