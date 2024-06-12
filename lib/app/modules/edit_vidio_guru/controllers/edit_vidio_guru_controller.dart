import 'package:get/get.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class EditVidioGuruController extends GetxController {
  late TextEditingController judulController;
  late TextEditingController linkytController;
  late TextEditingController descController;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
 

  

  @override
  void onInit() {
    judulController = TextEditingController();
    linkytController = TextEditingController();
    descController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    judulController.dispose();
    linkytController.dispose();
    descController.dispose();
    super.onClose();
  }

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection('materi_vidio').doc(docID);
    DocumentSnapshot<Object?> snapshot = await docRef.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    judulController.text = data['judul'];
    linkytController.text = data['link'];
    descController.text = data['desc'];

    return snapshot;
  }

  void updateData(String docID, String judul, String desc, String linkyt) async {
    try {
     

      await firestore.collection('materi_vidio').doc(docID).update({
        'judul': judul,
        'desc': desc,
        'link': linkyt,
       
      });

      Get.back();
      Get.snackbar(
        'Success',
        'Data Berhasil Diedit',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
    } catch (e) {
      print(e);
      Get.snackbar(
        'Error',
        'Gagal Mengedit Data',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
    }
  }
}
