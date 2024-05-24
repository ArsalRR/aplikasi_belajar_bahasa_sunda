import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bhs_sunda_controller.dart';

class BhsSundaView extends GetView<BhsSundaController> {
  const BhsSundaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BhsSundaController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Materi Bahasa Sunda'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
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
    );
  }
}
