import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pai_controller.dart';

class PaiView extends StatelessWidget {
  final PaiController controller = Get.put(PaiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doa-Doa'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.pesanerror.isNotEmpty) {
          return Center(child: Text(controller.pesanerror.value));
        }

        return ListView.builder(
          itemCount: controller.pai.length,
          itemBuilder: (context, index) {
            final doa = controller.pai[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doa['doa'] ?? 'Unknown',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      doa['ayat'] ?? 'Unknown',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      doa['latin'] ?? 'Unknown',
                      style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Artinya: ${doa['artinya'] ?? 'Unknown'}',
                      style: TextStyle(fontSize: 14),
                    ),
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
