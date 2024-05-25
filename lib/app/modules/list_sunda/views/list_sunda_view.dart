import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/list_sunda_controller.dart';

class ListSundaView extends GetView<ListSundaController> {
  const ListSundaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bahasa Sunda'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ListTile(
              
              leading: Icon(Icons.book, color: Colors.orange, size: 40),
              title: Text('Materi Bahasa Sunda', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Ayo Belajar Bahasa Sunda'),
              onTap: () {
                Get.toNamed(Routes.BHS_SUNDA);
              },
            ),
          ),
          SizedBox(height: 20),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ListTile(
              leading: Icon(Icons.video_library, color: Colors.red, size: 40),
              title: Text('Video Pembelajaran', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Video Pembelajaran Bahasa Sunda'),
              onTap: () {
                // Add navigation or functionality here
              },
            ),
          ),
        ],
      ),
    );
  }
}
