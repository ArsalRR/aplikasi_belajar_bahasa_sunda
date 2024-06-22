import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TugasDetailController extends GetxController {
  var tugasId = ''.obs;
  var siswaList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    tugasId.value = Get.arguments;
    fetchSiswaList();
  }

  void fetchSiswaList() async {
    try {
      var resultsSnapshot = await FirebaseFirestore.instance
          .collection('results')
          .where('tugasId', isEqualTo: tugasId.value)
          .get();

      var userIds = resultsSnapshot.docs.map((doc) => doc['userId']).toList();

      var usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      var userMap = {for (var doc in usersSnapshot.docs) doc.id: doc['nama']};

      siswaList.value = resultsSnapshot.docs.map((doc) {
        var userId = doc['userId'];
        return {
          'userId': userId,
          'nama': userMap[userId] ?? 'Unknown',
          'score': doc['score'],
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil daftar siswa: $e');
    }
  }
}
