import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';


class DaftarTugasSiswaController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxBool isLoading = true.obs;
  final RxList<Map<String, dynamic>> tugasList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTugasList();
  }

  void fetchTugasList() async {
    try {
      isLoading.value = true;
      var tugasSnapshot = await firestore.collection('tugas').get();
      tugasList.value = tugasSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'namaTugas': doc['namaTugas'],
          'deskripsi': doc['deskripsi'],
        };
      }).toList();
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Gagal mengambil daftar tugas: $e',
        confirmBtnText: 'OK',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void deleteTugas(String tugasId) async {
    try {
      await firestore.collection('tugas').doc(tugasId).delete();
      fetchTugasList();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Tugas berhasil dihapus',
        confirmBtnText: 'OK',
      );
    } catch (e) {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Gagal menghapus tugas: $e',
        confirmBtnText: 'OK',
      );
    }
  }
}
