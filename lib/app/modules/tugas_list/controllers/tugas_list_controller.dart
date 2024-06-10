import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TugasListController extends GetxController {
  var tugasList = <Map<String, dynamic>>[].obs;
  var skorList = <String, int?>{}.obs;
  var isLoading = true.obs;
  String userId = '';

  @override
  void onInit() {
    super.onInit();
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      fetchTugasList();
    } else {
      Get.snackbar('Error', 'Tidak dapat menemukan ID pengguna.');
    }
  }

  void fetchTugasList() async {
    try {
      isLoading.value = true;
      var tugasSnapshot =
          await FirebaseFirestore.instance.collection('tugas').get();
      tugasList.value = tugasSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'namaTugas': doc['namaTugas'],
          'deskripsi': doc['deskripsi'],
        };
      }).toList();
      fetchScores();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil daftar tugas: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchScores() async {
    if (userId.isEmpty) return;

    try {
      var scoreSnapshot = await FirebaseFirestore.instance
          .collection('results')
          .where('userId', isEqualTo: userId)
          .get();

      scoreSnapshot.docs.forEach((doc) {
        var score = doc['score'];
        if (score is int) {
          skorList[doc['tugasId']] = score;
        } else if (score is String) {
          skorList[doc['tugasId']] = int.tryParse(score) ?? 0;
        } else {
          skorList[doc['tugasId']] = 0;
        }
      });
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil skor: $e');
    }
  }
}
