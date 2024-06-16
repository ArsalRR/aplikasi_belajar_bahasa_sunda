import 'package:capstone_project/app/widget/MenuWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.5,
                      color: const Color(0xff008DDA),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                                'Hai, ${controller.fullName.value}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          SizedBox(height: 8),
                          Text(
                            'Selamat Datang Kembali',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Column(
                        children: [
                          Obx(() {
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  showMenu(
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                        size.width, kToolbarHeight + 40, 0, 0),
                                    items: [
                                      PopupMenuItem<String>(
                                        value: 'setting',
                                        child: Text('Setting'),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'logout',
                                        child: Text('Keluar'),
                                      ),
                                    ],
                                  ).then((value) {
                                    if (value == 'setting') {
                                      Get.toNamed('/setting');
                                    } else if (value == 'logout') {
                                      QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.confirm,
                                        title: 'Konfirmasi',
                                        text: 'Apakah Anda yakin ingin keluar?',
                                        confirmBtnText: 'Ya',
                                        cancelBtnText: 'Tidak',
                                        onConfirmBtnTap: () {
                                          controller.logout();
                                          Get.snackbar(
                                            'Keluar',
                                            'Sampai Jumpa Lagi',
                                            snackPosition: SnackPosition.TOP,
                                          );

                                          Navigator.of(context).pop();
                                        },
                                      );
                                    }
                                  });
                                },
                                child: CircleAvatar(
                                  backgroundImage: controller
                                          .profileImageUrl.value.isNotEmpty
                                      ? NetworkImage(
                                          controller.profileImageUrl.value)
                                      : AssetImage('assets/img/gamer.png')
                                          as ImageProvider,
                                  radius: 20,
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                transform: Matrix4.translationValues(0.0, -120.0, 0.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: GridView.count(
                  crossAxisCount: 3,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    MenuWidget(
                      icon_path: "assets/svg/book.svg",
                      title: "Materi Pelajaran",
                      link: "/list-sunda",
                    ),
                    MenuWidget(
                      icon_path: "assets/svg/task.svg",
                      title: "Tugas",
                      link: "/tugas-list",
                    ),
                    MenuWidget(
                      icon_path: "assets/svg/school.svg",
                      title: "Tentang Sekolah",
                      link: "/tentang-sekolah",
                    ),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                child: Text("Berbasu SMP Serang Baru"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
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
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[index];
                        var data = doc.data() as Map<String, dynamic>;
                        bool isBlueCard = index % 2 == 0;

                        return GestureDetector(
                          onTap: () async {
                            var url = data['link'] ?? '';
                            if (url.isNotEmpty) {
                              final uri = Uri.parse(url);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              } else {
                                QuickAlert.show(
                                  context: Get.context!,
                                  type: QuickAlertType.error,
                                  title: 'Gagal',
                                  text: 'Link tidak dapat diakses: $url',
                                );
                              }
                            } else {
                              QuickAlert.show(
                                context: Get.context!,
                                type: QuickAlertType.warning,
                                title: 'Perhatian',
                                text: 'Link tidak tersedia untuk video ini.',
                              );
                            }
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isBlueCard
                                    ? Color(0xff008DDA)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4.0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['judul'] ?? 'No Title',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: isBlueCard
                                            ? Colors.white
                                            : Colors.black,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.play_circle_fill,
                                          color: isBlueCard
                                              ? Colors.white
                                              : Color(0xff008DDA),
                                          size: 40,
                                        ),
                                      ],
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
        ),
      ),
    );
  }
}
