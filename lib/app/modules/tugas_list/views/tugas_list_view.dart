import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tugas_list_controller.dart';

class TugasListView extends GetView<TugasListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (controller.tugasList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.tugasList.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada tugas yang tersedia.',
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: controller.tugasList.length,
              itemBuilder: (context, index) {
                var tugas = controller.tugasList[index];
                var score = controller.skorList[tugas['id']];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed('/tugas-siswa', arguments: tugas['id']);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.0),
                      title: Text(
                        tugas['namaTugas'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(tugas['deskripsi']),
                      trailing: score != null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(height: 4.0),
                                Text('Skor: $score'),
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.pending, color: Colors.orange),
                                SizedBox(height: 4.0),
                                Text('Belum dikerjakan'),
                              ],
                            ),
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
