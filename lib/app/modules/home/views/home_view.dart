import 'package:capstone_project/app/widget/KategoriWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

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
                            'Hai, $userEmail',
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
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(size.width, kToolbarHeight, 0, 0),
                              items: [
                                PopupMenuItem<String>(
                                  value: 'logout',
                                  child: Text('Keluar'),
                                ),
                              ],
                            ).then((value) {
                              if (value == 'logout') {
                                controller.logout();
                                Get.snackbar(
                                  'Keluar',
                                  'Sampai Jumpa Lagi',
                                  snackPosition: SnackPosition.TOP,
                                );
                              }
                            });
                          },
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/img/gamer.png'),
                            radius: 20,
                          ),
                        ),
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
                    KategoriWidget(
                      icon_path: "assets/svg/man.svg",
                      title: "Bahasa Sunda",
                      link: "/list-sunda",
                    ),
                    KategoriWidget(
                      icon_path: "assets/svg/video.svg",
                      title: "Fiqih",
                      link: "/",
                    ),
                    KategoriWidget(
                      icon_path: "assets/svg/book.svg",
                      title: "Daftar Tugas",
                      link: "/",
                    ),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                child: Text("LMS SMP Serang Baru"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
