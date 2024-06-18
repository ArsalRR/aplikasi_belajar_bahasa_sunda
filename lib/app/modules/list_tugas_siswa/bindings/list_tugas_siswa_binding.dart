import 'package:get/get.dart';

import '../controllers/list_tugas_siswa_controller.dart';

class ListTugasSiswaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListTugasSiswaController>(
      () => ListTugasSiswaController(),
    );
  }
}
