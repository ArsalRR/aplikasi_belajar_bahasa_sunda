import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/datar_nilai_controller.dart';

class DatarNilaiView extends GetView<DatarNilaiController> {
  const DatarNilaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Daftar Nilai Siswa',
            style: TextStyle(fontSize: 14),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Tugas yang sudah dikerjakan",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200, left: 30, right: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            child: Text(
                              " > Mengumpulkan",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )),
                      Expanded(
                        child: ListView.builder(
                          itemCount: 8,
                          // Number of items in the ListView
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: SizedBox(
                                height: 70,
                                child: Card(
                                  color: Colors.blue[400],
                                  child: ListTile(
                                    trailing: Icon(
                                      Icons.assignment,
                                      color: Colors.white,
                                    ),
                                    title: Text('Abdi ${index + 1}'),
                                    subtitle: Text(
                                      'Nilai ${index + 5}',
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
