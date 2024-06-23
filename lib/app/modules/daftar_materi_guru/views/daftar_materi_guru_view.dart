import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import '../controllers/daftar_materi_guru_controller.dart';


class DaftarMateriGuruView extends GetView<DaftarMateriGuruController> {
  const DaftarMateriGuruView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildAppBar(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: ClipPath(
        clipper: WaveClipperOne(),
        child: Container(
          height: 150,
          color: Color(0xff008DDA),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Materi Video Guru',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 160.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: controller.streamData(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return _buildListView(snapshot.data!.docs);
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  Widget _buildListView(List<QueryDocumentSnapshot> docs) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 16.0),
      itemCount: docs.length,
      itemBuilder: (context, index) {
        var document = docs[index];
        var data = document.data() as Map<String, dynamic>;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                data['judul'] ?? 'No Title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                ),
              ),
              subtitle: _buildSubtitle(data),
              trailing: _buildTrailingButtons(document.id),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubtitle(Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          'Link Youtube:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          data['link'] ?? '',
          style: TextStyle(
            fontSize: 14,
            color: Colors.blue,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Deskripsi Materi:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontFamily: 'Poppins',
          ),
        ),
        Text(
          data['desc'] ?? 'No Description',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }

  Widget _buildTrailingButtons(String docId) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => Get.toNamed(Routes.EDIT_VIDIO_GURU, arguments: docId),
          icon: Icon(Icons.edit, color: Colors.black),
        ),
        IconButton(
          onPressed: () => controller.deleteData(docId),
          icon: Icon(Icons.delete, color: Colors.red),
        ),
      ],
    );
  }
}
