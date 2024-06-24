import 'package:capstone_project/app/modules/login/views/login_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  final RxString fullName = ''.obs;
  final RxString email = ''.obs;
  final RxString profileImageUrl = ''.obs;
  final count = 0.obs;

  var tugasList = <Map<String, dynamic>>[].obs;
  var skorList = <String, int?>{}.obs;
  var isLoading = true.obs;
  String userId = '';

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId.isNotEmpty) {
      fetchTugasList();
    } else {
      Get.snackbar('Error', 'Tidak dapat menemukan ID pengguna.');
    }
  }

  void fetchUserData() async {
    try {
      isLoading.value = true;
      User? user = auth.currentUser;
      if (user != null) {
        email.value = user.email ?? '';
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists) {
          Map<String, dynamic>? userData =
              userDoc.data() as Map<String, dynamic>?;

          fullName.value = userData?['nama'] ?? '';

          if (userData != null &&
              userData.containsKey('profileImageUrl') &&
              userData['profileImageUrl'].toString().isNotEmpty) {
            profileImageUrl.value = userData['profileImageUrl'];
          } else {
            profileImageUrl.value = '';
            Get.snackbar(
              'Info',
              'Foto belum diganti, menggunakan gambar default.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.yellow,
              colorText: Colors.black,
              icon: Icon(Icons.info, color: Colors.black),
            );
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal Mendapatkan Data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection('materi_vidio');
    return data.orderBy('judul', descending: true).snapshots();
  }

  void increment() => count.value++;

  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
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
