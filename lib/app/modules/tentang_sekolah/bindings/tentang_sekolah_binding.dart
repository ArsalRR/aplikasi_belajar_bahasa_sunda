import 'package:get/get.dart';

import '../controllers/tentang_sekolah_controller.dart';

class TentangSekolahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TentangSekolahController>(
      () => TentangSekolahController(),
    );
  }
}
