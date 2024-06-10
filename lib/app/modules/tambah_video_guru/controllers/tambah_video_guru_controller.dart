import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:quickalert/quickalert.dart';

class TambahVideoGuruController extends GetxController {
  late TextEditingController judulController;
  late TextEditingController descController;
  late TextEditingController linkytController;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    judulController = TextEditingController();
    descController = TextEditingController();
    linkytController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    judulController.dispose();
    descController.dispose();
    linkytController.dispose();
    super.onClose();
  }

  void addData(String judul, String link, String desc) async {
    try {
      await firestore.collection('materi_vidio').add({
        'judul': judul,
        'link': link,
        'desc': desc,
      });

      judulController.clear();
      descController.clear();
      linkytController.clear();

      Get.back();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        title: 'Berhasil',
        text: 'Data Behasil Disimpan',
      );
    } catch (e) {
      print(e);
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Gagal',
        text: 'Gagal Tambah data: $e',
      );
    }
  }
}
