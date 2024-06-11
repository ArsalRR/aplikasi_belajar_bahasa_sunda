import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TugasSiswaController extends GetxController {
  var soalList = [].obs;
  var selectedAnswers = <int?>[].obs;
  var isLoading = true.obs;
  var tugasId = ''.obs;
  var skor = 0.obs;
  var isTaskCompleted = false.obs;
  String userId = '';
  var correctAnswers = <int?>[].obs;
  var answerStatus = <bool?>[].obs;

  @override
  void onInit() {
    super.onInit();
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    tugasId.value = Get.arguments;
    if (userId.isNotEmpty) {
      fetchSoalList(tugasId.value);
      checkIfTaskCompleted(tugasId.value);
    } else {
      Get.snackbar('Error', 'Tidak dapat menemukan ID pengguna.');
    }
  }

  void fetchSoalList(String tugasId) {
    FirebaseFirestore.instance
        .collection('soal')
        .where('tugasId', isEqualTo: tugasId)
        .snapshots()
        .listen((snapshot) {
      soalList.value = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'soalText': doc['soalText'],
          'pilihanList': List<String>.from(
              doc['pilihanList'].map((pilihan) => pilihan['text'])),
          'jawabanBenar': doc['jawabanBenar'],
        };
      }).toList();

      selectedAnswers.value = List<int?>.filled(soalList.length, null);
      correctAnswers.value =
          soalList.map((soal) => soal['jawabanBenar'] as int?).toList();
      answerStatus.value = List<bool?>.filled(soalList.length, null);
      isLoading.value = false;
    });
  }

  void checkIfTaskCompleted(String tugasId) async {
    if (userId.isEmpty) return;

    var resultSnapshot = await FirebaseFirestore.instance
        .collection('results')
        .where('tugasId', isEqualTo: tugasId)
        .where('userId', isEqualTo: userId)
        .get();

    if (resultSnapshot.docs.isNotEmpty) {
      isTaskCompleted.value = true;
      var score = resultSnapshot.docs.first['score'];
      if (score is int) {
        skor.value = score;
      } else if (score is String) {
        skor.value = int.tryParse(score) ?? 0;
      } else {
        skor.value = 0;
      }
      Get.snackbar(
          'Info', 'Tugas sudah diselesaikan dengan skor: ${skor.value}');
    }
  }

  void submitAnswers() async {
    if (isTaskCompleted.value) return;

    int calculatedScore = calculateScore();

    await FirebaseFirestore.instance.collection('results').add({
      'tugasId': tugasId.value,
      'userId': userId,
      'score': calculatedScore,
      'timestamp': FieldValue.serverTimestamp(),
    });

    isTaskCompleted.value = true;
    skor.value = calculatedScore;
    updateAnswerStatus();
    Get.snackbar('Info', 'Tugas selesai dengan skor: $calculatedScore');
  }

  int calculateScore() {
    int score = 0;
    for (int i = 0; i < soalList.length; i++) {
      if (selectedAnswers[i] != null &&
          selectedAnswers[i] == soalList[i]['jawabanBenar']) {
        score++;
      }
    }
    return score;
  }

  void updateAnswerStatus() {
    for (int i = 0; i < soalList.length; i++) {
      answerStatus[i] = selectedAnswers[i] == correctAnswers[i];
    }
    update();
  }
}
