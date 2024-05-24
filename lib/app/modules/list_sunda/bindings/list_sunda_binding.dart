import 'package:get/get.dart';

import '../controllers/list_sunda_controller.dart';

class ListSundaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListSundaController>(
      () => ListSundaController(),
    );
  }
}
