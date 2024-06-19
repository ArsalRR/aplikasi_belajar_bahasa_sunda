import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../controllers/list_tugas_siswa_controller.dart';

class ListTugasSiswaView extends GetView<ListTugasSiswaController> {
  const ListTugasSiswaView({Key? key}) : super(key: key);
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                height: 150,
                color: Color(0xff008DDA),
                child: AppBar(
                  title: const Text(
                    'List Menu Tugas',
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 160.0),
            child: ListView(
              padding: EdgeInsets.all(17.0),
              children: [
                buildCard(
                  imageUrl: 'assets/img/writing.png',
                  title: 'Tambah Tugas Siswa',
                  subtitle: 'Temukan keterampilan terbaik dirimu',
                  onTap: () {
                    Get.toNamed(Routes.ADD_SOAL);
                  },
                ),
                SizedBox(height: 21),
                buildCard(
                  imageUrl: 'assets/img/book.png',
                  title: 'Daftar Tugas Siswa',
                  subtitle: 'Lihat video untuk tingkatkan bahasamu',
                  onTap: () {
                    Get.toNamed(Routes.DAFTAR_TUGAS_SISWA);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard({
    required String imageUrl,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          height: 100,
          child: Row(
            children: [
              Image.asset(
                imageUrl,
                width: 70,
                height: 90,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(subtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
