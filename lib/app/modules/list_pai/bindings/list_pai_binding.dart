import 'package:get/get.dart';

import '../controllers/list_pai_controller.dart';

class ListPaiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPaiController>(
      () => ListPaiController(),
    );
  }
}
