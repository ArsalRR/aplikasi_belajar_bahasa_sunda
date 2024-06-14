import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditVidioGuruController extends GetxController {
  late TextEditingController judulController;
  late TextEditingController linkController;
  late TextEditingController descController;
 
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    DocumentReference docRef = firestore.collection('materi_vidio').doc(docID);
    return docRef.get();
  }

  void updateData(String docID, String judul, String link, String desc) async {
      QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Menyimpan data...',
    );

    try {
      await firestore.collection('materi_vidio').doc(docID).update({
        'judul': judul,
        'link': link,
        'desc': desc,
       
      });

     Get.back();
     await Future.delayed(Duration(seconds: 2));
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        title: 'Berhasil',
        text: 'Data Berhasil Disimpan',
      );
    } catch (e) {
      print(e);
     QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Gagal',
        text: 'Data Gagal  Disimpan',
      );
    }
  }

  @override
  void onInit() {
    judulController = TextEditingController();
    linkController = TextEditingController();
    descController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    judulController.dispose();
    linkController.dispose();
    descController.dispose();
    super.onClose();
  }
}
