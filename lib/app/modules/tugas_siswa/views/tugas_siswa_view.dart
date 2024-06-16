import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../controllers/tugas_siswa_controller.dart';

class TugasSiswaView extends StatefulWidget {
  @override
  _TugasSiswaViewState createState() => _TugasSiswaViewState();
}

class _TugasSiswaViewState extends State<TugasSiswaView> {
  final TugasSiswaController controller = Get.put(TugasSiswaController());

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
                    'Tugas Siswa',
                    style: TextStyle(color: Colors.white),
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
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: controller.soalList.length,
                  itemBuilder: (context, index) {
                    var soal = controller.soalList[index];
                    var selectedAnswer = controller.selectedAnswers[index];
                    var isCorrect = controller.answerStatus[index];

                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              soal['soalText'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: List.generate(soal['pilihanList'].length,
                                  (pilihanIndex) {
                                String pilihanText =
                                    soal['pilihanList'][pilihanIndex];
                                Color buttonColor;

                                if (controller.isTaskCompleted.value) {
                                  if (pilihanIndex == selectedAnswer) {
                                    buttonColor = isCorrect == true
                                        ? Colors.green
                                        : Colors.red;
                                  } else if (pilihanIndex ==
                                      soal['jawabanBenar']) {
                                    buttonColor = Colors.green;
                                  } else {
                                    buttonColor = Colors.grey.shade200;
                                  }
                                } else {
                                  buttonColor = pilihanIndex == selectedAnswer
                                      ? Colors.blue
                                      : Colors.grey.shade200;
                                }

                                return GestureDetector(
                                  onTap: controller.isTaskCompleted.value
                                      ? null
                                      : () {
                                          setState(() {
                                            controller.selectedAnswers[index] =
                                                pilihanIndex;
                                          });
                                        },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 4.0),
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: buttonColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${String.fromCharCode(65 + pilihanIndex)}. ',
                                          style: TextStyle(
                                            color: controller
                                                    .isTaskCompleted.value
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            pilihanText,
                                            style: TextStyle(
                                              color: controller
                                                      .isTaskCompleted.value
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        if (controller.isTaskCompleted.value) {
          return Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.grey.shade200,
            child: ElevatedButton(
              onPressed: null,
              child: Text(
                'Skor: ${controller.skor.value}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.blue,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  controller.submitAnswers();
                });
              },
              child: Text(
                'Selesai',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          );
        }
      }),
    );
  }
}
