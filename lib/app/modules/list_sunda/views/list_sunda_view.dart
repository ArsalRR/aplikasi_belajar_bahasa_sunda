import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import '../controllers/list_sunda_controller.dart';

class ListSundaView extends GetView<ListSundaController> {
  const ListSundaView({Key? key}) : super(key: key);

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
                    'Materi Bahasa Sunda',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold
                    ),
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
            padding: const EdgeInsets.only(top: 160.0),
            child: ListView(
              padding: EdgeInsets.all(17.0),
              children: [
                buildCard(
                  imageUrl: 'assets/img/studying.png',
                  title: 'Materi Bahasa Sunda',
                  subtitle: 'Temukan keterampilan terbaik dirimu',
                  onTap: () {
                    Get.toNamed(Routes.BHS_SUNDA);
                  },
                ),
                SizedBox(height: 21),
                buildCard(
                  imageUrl: 'assets/img/videonew.png',
                  title: 'Vidio Pembelajaran',
                  subtitle: 'Lihat vidio untuk tingkatkan bahasamu',
                  onTap: () {
                    Get.toNamed(Routes.VIDIO_PEMBELAJARAN);
                  },
                ),
              ],
            ),
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
                width: 70,
                height: 90,
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
                        fontSize: 13,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                      ),
                    ),
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
