import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart'; 

import '../controllers/edit_vidio_guru_controller.dart';

class EditVidioGuruView extends GetView<EditVidioGuruController> {
  const EditVidioGuruView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    final ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);

    void validateFields(String initialJudul, String initialLink, String initialDesc) {
      isButtonEnabled.value = controller.judulController.text != initialJudul ||
                              controller.linkController.text != initialLink ||
                              controller.descController.text != initialDesc;
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(170.0),
        child: ClipPath(
          clipper: WaveClipperOne(),
          child: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              "Edit Materi Vidio",
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
        child: FutureBuilder<DocumentSnapshot<Object?>>(
          future: controller.getData(Get.arguments),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              var data = snapshot.data!;
              var initialJudul = data['judul'];
              var initialLink = data['link'];
              var initialDesc = data['desc'];

              controller.judulController.text = initialJudul;
              controller.linkController.text = initialLink;
              controller.descController.text = initialDesc;
              controller.judulController.addListener(() => validateFields(initialJudul, initialLink, initialDesc));
              controller.linkController.addListener(() => validateFields(initialJudul, initialLink, initialDesc));
              controller.descController.addListener(() => validateFields(initialJudul, initialLink, initialDesc));

              return ListView(
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
                    controller: controller.linkController,
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
                    maxLines: 10,
                    decoration: InputDecoration(
                      labelText: 'Description Materi',
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
                                controller.updateData(
                                  Get.arguments,
                                  controller.judulController.text,
                                  controller.linkController.text,
                                  controller.descController.text,
                                );
                              }
                            : null, 
                        child: Text(
                          'Simpan Perubahan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
