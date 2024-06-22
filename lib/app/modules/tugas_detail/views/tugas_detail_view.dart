import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tugas_detail_controller.dart';

class TugasDetailView extends StatelessWidget {
  final TugasDetailController controller = Get.put(TugasDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff008DDA),
        title: Text('Detail Tugas',
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() {
          if (controller.siswaList.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada siswa yang mengerjakan.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: controller.siswaList.length,
              itemBuilder: (context, index) {
                var siswa = controller.siswaList[index];

                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                siswa['nama'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Skor: ${siswa['score']}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
