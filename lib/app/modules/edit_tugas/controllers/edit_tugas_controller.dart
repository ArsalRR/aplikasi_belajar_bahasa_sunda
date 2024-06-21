import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditTugasController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxBool isLoading = true.obs;
  final TextEditingController namaTugasController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  late String tugasId;
  var soalList = <Soal>[].obs;

  @override
  void onInit() {
    super.onInit();
    final tugas = Get.arguments as Map<String, dynamic>;
    tugasId = tugas['id'];
    namaTugasController.text = tugas['namaTugas'];
    deskripsiController.text = tugas['deskripsi'];
    fetchSoalList(tugasId);
  }

  void fetchSoalList(String tugasId) async {
    isLoading.value = true;
    try {
      var soalSnapshot = await firestore
          .collection('soal')
          .where('tugasId', isEqualTo: tugasId)
          .get();

      soalList.value = soalSnapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return Soal.fromMap(data);
      }).toList();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data soal: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addSoal() {
    soalList.add(Soal(
      soalText: '',
      pilihanList: [
        Pilihan(text: ''),
        Pilihan(text: ''),
        Pilihan(text: ''),
        Pilihan(text: '')
      ],
      jawabanBenar: -1,
    ));
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

  Future<void> updateTugas() async {
    if (namaTugasController.text.isNotEmpty) {
      isLoading.value = true;

      final updatedData = {
        'namaTugas': namaTugasController.text,
        'deskripsi': deskripsiController.text,
      };

      try {
        await firestore.collection('tugas').doc(tugasId).update(updatedData);

        for (var soal in soalList) {
          if (soal.id == null) {
            var newDoc = await firestore.collection('soal').add({
              ...soal.toMap(),
              'tugasId': tugasId,
            });
            soal.id = newDoc.id;
          } else {
            await firestore.collection('soal').doc(soal.id).update({
              ...soal.toMap(),
              'tugasId': tugasId,
            });
          }
        }

        Get.snackbar('Success', 'Tugas dan soal berhasil diperbarui',
            snackPosition: SnackPosition.BOTTOM);
        fetchSoalList(tugasId);
      } catch (e) {
        Get.snackbar('Error', 'Gagal memperbarui tugas: $e',
            snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Nama tugas tidak boleh kosong',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    namaTugasController.dispose();
    deskripsiController.dispose();
    super.onClose();
  }
}

class Soal {
  String? id;
  String soalText;
  List<Pilihan> pilihanList;
  int jawabanBenar;

  Soal({
    this.id,
    required this.soalText,
    required this.pilihanList,
    required this.jawabanBenar,
  });

  Map<String, dynamic> toMap() {
    return {
      'soalText': soalText,
      'pilihanList': pilihanList.map((pilihan) => pilihan.toMap()).toList(),
      'jawabanBenar': jawabanBenar,
    };
  }

  factory Soal.fromMap(Map<String, dynamic> map) {
    return Soal(
      id: map['id'],
      soalText: map['soalText'],
      pilihanList: List<Pilihan>.from(
        map['pilihanList'].map((pilihan) => Pilihan.fromMap(pilihan)),
      ),
      jawabanBenar: map['jawabanBenar'],
    );
  }
}

class Pilihan {
  String text;

  Pilihan({required this.text});

  Map<String, dynamic> toMap() {
    return {'text': text};
  }

  factory Pilihan.fromMap(Map<String, dynamic> map) {
    return Pilihan(text: map['text']);
  }
}
