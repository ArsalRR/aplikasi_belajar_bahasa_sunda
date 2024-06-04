import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/app/modules/login/views/login_view.dart';
class HomeGuruController extends GetxController {
  //TODO: Implement HomeGuruController
      FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
    void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }
}
