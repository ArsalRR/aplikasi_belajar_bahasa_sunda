import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/app/modules/login/views/login_view.dart';

class HomeGuruController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final RxString fullname = ''.obs;
  final RxString email = ''.obs;
  final RxString profileImageUrl = ''.obs;
  final RxList<Map<String, dynamic>> tugasList = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = true.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchTugasList();
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

  void fetchTugasList() async {
    try {
      isLoading.value = true;
      var tugasSnapshot = await firestore.collection('tugas').get();
      tugasList.value = tugasSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'namaTugas': doc['namaTugas'],
          'deskripsi': doc['deskripsi'],
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil daftar tugas: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void deleteTugas(String tugasId) async {
    try {
      await firestore.collection('tugas').doc(tugasId).delete();
      fetchTugasList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus tugas: $e');
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
