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
        title: const Text(' Bahasa Sunda'
        
        
        ),
  
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          Card(
            child: ListTile(
              title: Text('Materi Bahasa Sunda'),
              subtitle: Text('Ayo Belajar Bahasa Sunda'),
              onTap: () {
                Get.toNamed(Routes.BHS_SUNDA);
              },
            ),
          ),
          SizedBox(height: 20),
          Card(
            child: ListTile(
              title: Text('Vidio Pembelajaran'),
              subtitle: Text('Vidio Pembelajaran Bahasa Sunda'),
              onTap: () {
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
