import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../controllers/tambah_video_guru_controller.dart';

class TambahVideoGuruView extends GetView<TambahVideoGuruController> {
  const TambahVideoGuruView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);
    void validateFields() {
      isButtonEnabled.value = controller.judulController.text.isNotEmpty &&
                              controller.linkytController.text.isNotEmpty &&
                              controller.descController.text.isNotEmpty;
    }

    controller.judulController.addListener(validateFields);
    controller.linkytController.addListener(validateFields);
    controller.descController.addListener(validateFields);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.0),
        child: ClipPath(
          clipper: WaveClipperOne(),
          child: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              "Tambah Materi Vidio",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
        ),
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
                hintText: 'Masukkan Link Youtube video',
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
              maxLines: 6,
              decoration: InputDecoration(
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
            SizedBox(height: 20),
            ValueListenableBuilder<bool>(
              valueListenable: isButtonEnabled,
              builder: (context, isEnabled, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  onPressed: isEnabled
                      ? () {
                          controller.addData(
                            controller.judulController.text,
                            controller.linkytController.text,
                            controller.descController.text,
                          );
                        }
                      : null, 
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
