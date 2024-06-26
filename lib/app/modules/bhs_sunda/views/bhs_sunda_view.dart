import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import '../controllers/bhs_sunda_controller.dart';

class BhsSundaView extends GetView<BhsSundaController> {
  const BhsSundaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BhsSundaController());

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
                    style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
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
            padding: const EdgeInsets.only(top: 150.0),
            child: Obx(() {
              if (controller.isLoading.value && !controller.isDialogShowing.value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.loading,
                    title: 'Tunggu',
                    text: 'Sedang menampilkan materi',
                  );
                  controller.isDialogShowing.value = true;
                });
              }

              if (!controller.isLoading.value && controller.isDialogShowing.value) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pop();
                  controller.isDialogShowing.value = false;
                });
              }

              if (controller.pesanerror.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.pesanerror.value,
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: controller.sunda.length,
                itemBuilder: (context, index) {
                  final word = controller.sunda[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sorangan: ${word['sorangan']}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Batur: ${word['batur']}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Loma: ${word['loma']}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Bahasa Indonesia: ${word['bindo']}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Bahasa Inggris: ${word['english']}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Image.asset(
                              'assets/img/sunda.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
