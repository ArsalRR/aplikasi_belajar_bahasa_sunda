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
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          SizedBox(
            height: 200, 
            child: Card(
              child: ListTile(
                title: Text('Materi PAI'),
                subtitle: Text('Ayo Belajar Pai'),
                onTap: () {
                  Get.toNamed(Routes.PAI);
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: Card(
              child: ListTile(
                title: Text('Vidio Pembelajaran'),
                subtitle: Text('Vidio Pembelajaran Bahasa Sunda'),
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
