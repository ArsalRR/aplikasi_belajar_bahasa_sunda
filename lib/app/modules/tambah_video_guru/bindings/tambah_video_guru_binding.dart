import 'package:get/get.dart';

import '../controllers/tambah_video_guru_controller.dart';

class TambahVideoGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahVideoGuruController>(
      () => TambahVideoGuruController(),
    );
  }
}
