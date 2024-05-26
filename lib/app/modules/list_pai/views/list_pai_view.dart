import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/list_pai_controller.dart';

class ListPaiView extends GetView<ListPaiController> {
  const ListPaiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendidikan Agama Islam'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(
            height: 100,
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListTile(
                leading: Icon(Icons.book, color: Colors.orange, size: 40),
                title: Text('Materi Pendidikan Agama Islam', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Ayo Belajar Agama Islam'),
                onTap: () {
                  Get.toNamed(Routes.PAI);
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 100,
            child: Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ListTile(
                leading: Icon(Icons.video_library, color: Colors.red, size: 40),
                title: Text('Materi Video Pembelajaran', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Ayo Belajar Agama Islam'),
                onTap: () {
                
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
