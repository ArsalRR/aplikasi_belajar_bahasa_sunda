import 'package:get/get.dart';

import '../controllers/list_materi_guru_controller.dart';

class ListMateriGuruBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListMateriGuruController>(
      () => ListMateriGuruController(),
    );
  }
}
