import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatarNilaiController extends GetxController {
  var tugasList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTugasList();
  }

  void fetchTugasList() async {
    try {
      var snapshot = await FirebaseFirestore.instance.collection('tugas').get();
      tugasList.value = snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'namaTugas': doc['namaTugas'],
          'deskripsi': doc['deskripsi'],
          'jumlahPengumpul': 0,
        };
      }).toList();
      await fetchJumlahPengumpul();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil daftar tugas: $e');
    }
  }

  Future<void> fetchJumlahPengumpul() async {
    try {
      var tugasListCopy = List<Map<String, dynamic>>.from(tugasList);
      for (int i = 0; i < tugasListCopy.length; i++) {
        var tugas = tugasListCopy[i];
        var snapshot = await FirebaseFirestore.instance
            .collection('results')
            .where('tugasId', isEqualTo: tugas['id'])
            .get();

        tugasListCopy[i]['jumlahPengumpul'] = snapshot.docs.length;
      }

      tugasList.value = tugasListCopy;
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil jumlah pengumpul: $e');
    }
  }
}
