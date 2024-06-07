import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tentang_sekolah_controller.dart';

class TentangSekolahView extends GetView<TentangSekolahController> {
  const TentangSekolahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Tentang Sekolah"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 60, top: 20),
                        child: Column(
                          children: [
                            Text(
                              "Alamat",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                            Image.asset(
                              'assets/img/gambar4.png',
                              width: 500,
                              height: 500,
                            ),
                          ],
                        ))),
                SizedBox(
                  height: 10,
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Visi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Misi",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ])
              ],
            )
          ],
        ),
      ),
    );
  }
}
