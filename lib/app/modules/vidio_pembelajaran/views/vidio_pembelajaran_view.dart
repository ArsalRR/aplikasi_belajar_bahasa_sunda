import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/vidio_pembelajaran_controller.dart';

class VidioPembelajaranView extends GetView<VidioPembelajaranController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Pembelajaran'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Tidak ada video pembelajaran yang tersedia.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () async {
                  var url = data['link'] ?? '';
                  if (url.isNotEmpty) {
                    final uri = Uri.parse(url);
                    if (await canLaunch(uri.toString())) {
                      await launch(uri.toString());
                    } else {
                      Get.snackbar(
                        'Error',
                        'Could not launch $url',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 2),
                        margin: EdgeInsets.all(12),
                      );
                    }
                  }
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                        child: Image.network(
                          data['thumbnail'] ?? 'https://play-lh.googleusercontent.com/bbr47mb7zKuZWhonN6k3H4oiRSI3N6QE9C5qO8txR4CXapCbmHwzzSHhGQlCjJ8ALBo',
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['judul'] ?? 'No Title',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              data['desc'] ?? 'No Description',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Text(
                              data['link'] ?? 'Tidak Ada link',
                              style: TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
