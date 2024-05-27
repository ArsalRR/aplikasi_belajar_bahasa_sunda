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
          buildCard(
            imageUrl: 'assets/img/praying.png', 
            title: 'Materi Pendidikan Agama Islam',
            subtitle: 'Ayo Belajar Agama Islam',
            onTap: () {
              Get.toNamed(Routes.PAI);
            },
          ),
          SizedBox(height: 20),
          buildCard(
            imageUrl: 'assets/img/watching.png',
            title: 'Materi Video Pembelajaran',
            subtitle: 'Ayo Belajar Agama Islam',
            onTap: () {
             
            },
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
                width: 80,
                height: 80,
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
                        fontSize: 16,
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
