import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../controllers/tentang_sekolah_controller.dart';

class TentangSekolahView extends GetView<TentangSekolahController> {
  const TentangSekolahView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(170.0),
        child: ClipPath(
          clipper: WaveClipperOne(),
          child: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              "Tentang Sekolah",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(builder: (context, constraints) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 45)),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Text(
                      "Alamat",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/img/sekolah.jpg",
                    width: size.width * 0.88,
                    height: size.height * 0.28,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Text(
                      "Jayasampurna, Kec. Serang Baru, Kabupaten Bekasi, Jawa Barat 17330",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: Column(
                        children: [
                          Text(
                            "VISI SMPN1 SERANG BARU",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Terwujudnya Warga Sekolah Unggulan yang Religius, Cerdas, Terampil, Berkarakter dan Berwawasan Global",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40),
                          Text(
                            "MISI SMPN1 SERANG BARU",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: 6),
                          buildMissionItem(size,
                              'Menciptakan kenyamanan kegiatan beribadah bagi warga sekolah'),
                          buildMissionItem(size,
                              'Mewujudkan sistem pembelajaran yang kreatif dan inovatif'),
                          buildMissionItem(size,
                              'Mewadahi bakat minat peserta didik dalam kegiatan organisasi sekolah dan pengembangan diri'),
                          buildMissionItem(size,
                              'Mewujudkan pembiasaan pendidikan karakter dalam keseluruhan kegiatan sekolah'),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget buildMissionItem(Size size, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.01),
      child: Row(
        children: [
          Icon(Icons.circle, size: 6),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
