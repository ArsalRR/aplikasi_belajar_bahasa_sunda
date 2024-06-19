import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../data/models/soal_model.dart';
import 'package:capstone_project/main.dart';

class AddSoalController extends GetxController {
  final TextEditingController namaTugasController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  var soalList = <Soal>[].obs;

  void addSoal() {
    soalList.add(Soal(
        soalText: '',
        pilihanList: [
          Pilihan(text: ''),
          Pilihan(text: ''),
          Pilihan(text: ''),
          Pilihan(text: '')
        ],
        jawabanBenar: -1));
  }

  void removeSoal(int index) {
    if (index >= 0 && index < soalList.length) {
      soalList.removeAt(index);
    }
  }

  void addPilihan(int soalIndex) {
    if (soalIndex >= 0 && soalIndex < soalList.length) {
      soalList[soalIndex].pilihanList.add(Pilihan(text: ''));
      soalList.refresh();
    }
  }

  void removePilihan(int soalIndex, int pilihanIndex) {
    if (soalIndex >= 0 &&
        soalIndex < soalList.length &&
        pilihanIndex >= 0 &&
        pilihanIndex < soalList[soalIndex].pilihanList.length) {
      soalList[soalIndex].pilihanList.removeAt(pilihanIndex);
      soalList.refresh();
    }
  }

  Future<void> saveTugas() async {
    if (namaTugasController.text.isNotEmpty) {
      final tugasData = {
        'namaTugas': namaTugasController.text,
        'deskripsi': deskripsiController.text,
        'tanggal': Timestamp.now(),
      };

      try {
        final tugasDoc = await FirebaseFirestore.instance.collection('tugas').add(tugasData);

        for (var soal in soalList) {
          final soalData = soal.toMap();
          soalData['tugasId'] = tugasDoc.id;
          soalData['timestamp'] = Timestamp.now();

          await FirebaseFirestore.instance.collection('soal').add(soalData);
        }

        Get.snackbar('Success', 'Tugas berhasil disimpan');
        _showNotification('Tugas Baru', 'Tugas ${namaTugasController.text}');
        _resetForm();
      } catch (e) {
        Get.snackbar('Error', 'Gagal menyimpan tugas: $e');
      }
    } else {
      Get.snackbar('Error', 'Nama tugas tidak boleh kosong');
    }
  }

  void _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, title, body, platformChannelSpecifics);
  }

  void _resetForm() {
    namaTugasController.clear();
    deskripsiController.clear();
    soalList.clear();
  }

  @override
  void onClose() {
    namaTugasController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }
}
