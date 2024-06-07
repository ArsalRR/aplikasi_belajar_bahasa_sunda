import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  
  final RxString fullName = ''.obs;
  final RxString email = ''.obs;
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
      DocumentSnapshot userDoc = await firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        fullName.value = userDoc['nama'] ?? '';
      }
    }
  }

  void increment() => count.value++;
  
  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }
}
