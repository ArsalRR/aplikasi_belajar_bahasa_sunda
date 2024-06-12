import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../controllers/vidio_pembelajaran_controller.dart';

class VidioPembelajaranView extends GetView<VidioPembelajaranController> {
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
                    'Vidio Materi Bahasa Sunda',
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
            padding: const EdgeInsets.only(top: 140.0),
            child: StreamBuilder<QuerySnapshot>(
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
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
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
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: index % 2 == 0 ? Color(0xffFF4081) : Color(0xff303F9F),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.video_library,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        data['judul'] ?? 'No Title',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  data['desc'] ?? 'No Description',
                                  style: TextStyle(fontSize: 16, color: Colors.white70),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () async {
                                    var url = data['link'] ?? '';
                                    if (url.isNotEmpty) {
                                      final uri = Uri.parse(url);
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(uri);
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
                                  child: Text(
                                    data['link'] ?? 'Tidak Ada link',
                                    style: TextStyle(fontSize: 16, color: Colors.blue[200]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
