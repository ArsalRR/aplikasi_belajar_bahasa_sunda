import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';

class DaftarMateriGuruController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection('materi_vidio');
    return data.orderBy('judul', descending: true).snapshots();
  }

  void deleteData(String docID) {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.confirm,
        title: 'Yakin Hapus',
        text: 'Apakah Kamu yakin akan Hapus Profil ini?',
        confirmBtnText: 'Yes, I\'m sure',
        cancelBtnText: 'No',
        onConfirmBtnTap: () async {
          await firestore.collection('materi_vidio').doc(docID).delete();
          Get.back();
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.success,
            title: 'Success',
            text: 'Data deleted successfully',
            confirmBtnText: 'OK',
          );
        },
      );
    } catch (e) {
      print(e);
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Cannot delete this post',
        confirmBtnText: 'OK',
      );
    }
  }
}
