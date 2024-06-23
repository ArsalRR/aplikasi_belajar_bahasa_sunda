import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import '../controllers/daftar_tugas_siswa_controller.dart';

class DaftarTugasSiswaView extends GetView<DaftarTugasSiswaController> {
  const DaftarTugasSiswaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff008DDA),
        title: Text(
          'Daftar Tugas Siswa',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,

          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daftar Tugas",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(height: 15),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        } else if (controller.tugasList.isEmpty) {
                          return Center(
                            child: Text(
                              'Tidak ada tugas yang tersedia.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: controller.tugasList.length,
                            itemBuilder: (context, index) {
                              var tugas = controller.tugasList[index];
                              return GestureDetector(
                                onTap: () {},
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(tugas['deskripsi']),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              color: Colors.blue),
                                          onPressed: () {
                                            Get.toNamed('/edit-tugas',
                                                arguments: tugas);
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red),
                                          onPressed: () {
                                            QuickAlert.show(
                                              context: context,
                                              type: QuickAlertType.confirm,
                                              title: 'Konfirmasi',
                                              text:
                                                  'Apakah Anda yakin ingin menghapus tugas ini?',
                                              confirmBtnText: 'Ya',
                                              cancelBtnText: 'Tidak',
                                              onConfirmBtnTap: () {
                                                controller
                                                    .deleteTugas(tugas['id']);
                                                Get.snackbar(
                                                  'Tugas Dihapus',
                                                  'Tugas berhasil dihapus.',
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
