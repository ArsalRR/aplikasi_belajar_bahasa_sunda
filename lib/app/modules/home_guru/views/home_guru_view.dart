import 'package:capstone_project/app/widget/MenuWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

import '../controllers/home_guru_controller.dart';

class HomeGuruView extends GetView<HomeGuruController> {
  const HomeGuruView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final User? user = FirebaseAuth.instance.currentUser;
    final String userEmail = user?.email ?? 'User';

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
                          Text(
                            'Hai Guru, ${controller.fullname.value}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                          MouseRegion(
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
                                backgroundImage:
                                    AssetImage('assets/img/teacher.png'),
                                radius: 20,
                              ),
                            ),
                          ),
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
                      icon_path: "assets/svg/play.svg",
                      title: "Tambah Video",
                      link: "/list-materi-guru",
                    ),
                    MenuWidget(
                      icon_path: "assets/svg/creative-writing.svg",
                      title: "Tugas Siswa",
                      link: "/list-tugas-siswa",
                    ),
                    MenuWidget(
                      icon_path: "assets/svg/score.svg",
                      title: "Daftar Nilai",
                      link: "/datar-nilai",
                    ),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                child: Text(
                  "Dashboard Guru SMP Serang Baru",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
