import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/app/modules/login/views/login_view.dart';

class HomeGuruController extends GetxController {
  //TODO: Implement HomeGuruController
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final RxString fullname = ''.obs;
  final RxString email = ''.obs;
  final RxString profileImageUrl = ''.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
    User? user = auth.currentUser;
    if (user != null) {
      email.value = user.email ?? '';
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        fullname.value = userDoc['nama'] ?? '';
        profileImageUrl.value = userDoc['profileImageUrl'] ?? '';
      }
    }
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
