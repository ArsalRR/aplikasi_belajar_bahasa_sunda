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
            padding: const EdgeInsets.only(top: 120.0),
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
                return Center(child: Text(controller.pesanerror.value));
              }

              return ListView.builder(
                itemCount: controller.sunda.length,
                itemBuilder: (context, index) {
                  final word = controller.sunda[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sorangan: ${word['sorangan']}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          Text('Batur: ${word['batur']}', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          Text('Loma: ${word['loma']}', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          Text('Bahasa Indonesia: ${word['bindo']}', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          Text('Bahasa Inggris: ${word['english']}', style: const TextStyle(fontSize: 16)),
                        ],
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
