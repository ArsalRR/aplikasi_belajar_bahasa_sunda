import 'package:get/get.dart';

import '../controllers/daftar_tugas_siswa_controller.dart';

class DaftarTugasSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DaftarTugasSiswaController>(
      () => DaftarTugasSiswaController(),
    );
  }
}
