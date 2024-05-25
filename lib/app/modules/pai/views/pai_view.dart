import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/pai_controller.dart';

class PaiView extends StatelessWidget {
  final PaiController controller = Get.put(PaiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Color(0xFFCAF4FF), 
      appBar: AppBar(
        title: Text('Materi Pendidikan Agama Islam'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.pesanerror.isNotEmpty) {
          return Center(child: Text(controller.pesanerror.value));
        }

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final doa = controller.pai[index];
            return Container(
              color: Colors.grey.shade200,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: doa['doa'] ?? 'Unknown',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                              color: Colors.grey.shade800,
                            ),
                          )
                        ],
                        text: "${index + 1}. ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      doa['ayat'] ?? 'Unknown',
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: 28,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      doa['latin'] ?? 'Unknown',
                      style: TextStyle(
                        letterSpacing: 0.5,
                        color:Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      doa['artinya'] ?? 'Unknown',
                      style: TextStyle(
                        letterSpacing: 0.5,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 40,
            color: Color(0xFFCAF4FF),
          ),
          itemCount: controller.pai.length,
        );
      }),
    );
  }
}
