import 'package:get/get.dart';

import '../controllers/tugas_siswa_controller.dart';

class TugasSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TugasSiswaController>(
      () => TugasSiswaController(),
    );
  }
}
