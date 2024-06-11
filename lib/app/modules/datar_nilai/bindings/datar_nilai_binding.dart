import 'package:get/get.dart';

import '../controllers/datar_nilai_controller.dart';

class DatarNilaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DatarNilaiController>(
      () => DatarNilaiController(),
    );
  }
}
