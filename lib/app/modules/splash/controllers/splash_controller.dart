import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _NavigateToNextPage();
  }

  void _NavigateToNextPage() {
    Timer(Duration(seconds: 3), () {
      Get.offAllNamed('/login');
    });
  }
}
