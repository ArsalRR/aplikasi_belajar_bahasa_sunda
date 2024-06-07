import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tentang_sekolah_controller.dart';

class TentangSekolahView extends GetView<TentangSekolahController> {
  const TentangSekolahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Tentang Sekolah")
          
          ,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: LayoutBuilder(builder: (context, constraints) {
            // double screenWidth = MediaQuery.of(context).size.width;
            // double screenHeight = MediaQuery.of(context).size.width;

            // double horizontalPadding = screenWidth * 0.078;

            // double topPadding = screenHeight * 0.05;
            // double imageWidth = screenWidth * 0.85;
            // double imageHeight = screenHeight * 0.45;

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
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/img/sekolah.jpg",
                      width: size.width * 0.88,
                      height: size.height * 0.28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.06),
                      child: Text(
                        "Jayasampurna, Kec. Serang Baru, Kabupaten Bekasi, Jawa Barat 17330",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.06),
                          child: Column(
                            children: [
                              Text(
                                "VISI SMPN1 SERANG BARU",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Terwujudnya Warga Sekolah Unggulan yang Religius, Cerdas, Terampil, Berkarakter dan Berwawasan Global",
                                textAlign: TextAlign.justify,
                              ),
                              SizedBox(
                                height: 60,
                              ),
                              Text(
                                "MISI SMPN1 SERANG BARU",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.width * 0.01),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 6,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                        child: Text(
                                      'Menciptakan kenyamanan kegiatan beribadah bagi warga sekolah',
                                      textAlign: TextAlign.justify,
                                    ))
                                  ],
                                ),
                              ),
                              Text(
                                "\n- Mewujudkan sistem pembelajaran yang kreatif dan inovatif\n- Mewadahi bakat minat peserta didik dalam kegiatan organisasi sekolah dan pengembangan diri\n- Mewujudkan pembiasaan pendidikan karakter dalam keseluruhan kegiatan sekolah",
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              ),
            );
          }),
        ));
  }
}
