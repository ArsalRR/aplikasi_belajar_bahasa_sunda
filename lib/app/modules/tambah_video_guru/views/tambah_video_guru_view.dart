import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tambah_video_guru_controller.dart';

class TambahVideoGuruView extends GetView<TambahVideoGuruController> {
  const TambahVideoGuruView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Tambah Materi Vidio',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: controller.judulController,
              decoration: InputDecoration(
                labelText: 'Judul Materi',
                hintText: 'Masukkan Judul Materi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Judul Harus Di isi';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: controller.linkytController,
              decoration: InputDecoration(
                labelText: 'Link Youtube video',
                hintText: ' Masukkan Link Youtube video',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Link Youtube video Harus diisi ';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
                TextFormField(
              controller: controller.descController,
              decoration: InputDecoration(
                labelText: 'Description Materi',
                hintText: 'Masukkan Description Materi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Description Materi Harus di isi';
                }
                return null;
              },
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                controller.addData(
                  controller.judulController.text,
                  controller.linkytController.text,
                  controller.descController.text,
                );
              },
              child: Text(
                'Simpan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
