import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../controllers/daftar_materi_guru_controller.dart';

class DaftarMateriGuruView extends GetView<DaftarMateriGuruController> {
  const DaftarMateriGuruView({Key? key}) : super(key: key);

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
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    'Materi Video Guru',
                    style: TextStyle(color: Colors.white),
                  ),
                  centerTitle: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.streamData(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                    padding: EdgeInsets.only(top: 60.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data!.docs[index];
                      var data = document.data() as Map<String, dynamic>;

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 3.0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['judul'] ?? 'No Title',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text('Desc Materi: ${data['desc'] ?? ''}'),
                                    SizedBox(height: 5),
                                    Text('Link Youtube: ${data['link'] ?? ''}'),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => Get.toNamed(
                                  Routes.UPDATE_MATERI_VIDIO_GURU,
                                  arguments: document.id,
                                ),
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () => controller.deleteData(document.id),
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No data'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
