import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../controllers/tambah_video_guru_controller.dart';

class TambahVideoGuruView extends GetView<TambahVideoGuruController> {
  const TambahVideoGuruView({Key? key}) : super(key: key);

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
                    'Tambah Materi Video',
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
            padding: const EdgeInsets.only(top: 120.0),
            child: ListView(
              padding: EdgeInsets.all(17.0),
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.judulController,
                  decoration: InputDecoration(
                    labelText: 'Judul Materi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.book),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul Harus Diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.descController,
                  decoration: InputDecoration(
                    labelText: 'Desc Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.description),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Desc Harus Diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: controller.linkytController,
                  decoration: InputDecoration(
                    labelText: 'Masukkan Link Vidio Materi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    prefixIcon: Icon(Icons.video_library),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vidio Harus Diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    elevation: 3,
                  ),
                  onPressed: () {
                    controller.addData(
                      controller.judulController.text,
                      controller.linkytController.text,
                      controller.descController.text,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    child: Text(
                      'Tambah Materi Pembelajaran',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
