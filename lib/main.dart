import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_project/app/modules/login/controllers/login_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/loading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyATHaKgPOBKm7puAv132W6BxPj7Dy5D-Rs",
      appId: "1:790355774790:android:a0d7d3026b1e4097956947",
      messagingSenderId: "790355774790",
      projectId: "my-project-f34c5",
      storageBucket: "my-project-f34c5.appspot.com",
    ),
  );

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(LoginController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: authC.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingView();
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Aplikasi LMS SMP Serang Baru",
            initialRoute: Routes.SPLASH,
            getPages: AppPages.routes,
            theme: ThemeData(
              primarySwatch: Colors.indigo,
            ),
          );
        } else {
          return FutureBuilder<DocumentSnapshot>(
            future: authC.getUserData(snapshot.data!),
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return LoadingView();
              }

              if (userSnapshot.hasError) {
                return _buildErrorScreen(
                    'Terjadi kesalahan saat mengambil data pengguna..');
              }

              if (!userSnapshot.hasData || userSnapshot.data == null) {
                return _buildErrorScreen('Data pengguna tidak ditemukan.');
              }

              final userData =
                  userSnapshot.data!.data() as Map<String, dynamic>?;
              if (userData == null) {
                return _buildErrorScreen('Data pengguna tidak valid.');
              }

              final String role = userData['role'];

              if (role == 'Guru') {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Aplikasi LMS SMP Serang Baru",
                  initialRoute: Routes.HOME_GURU,
                  getPages: AppPages.routes,
                  theme: ThemeData(
                    primarySwatch: Colors.indigo,
                  ),
                );
              } else if (role == 'Siswa') {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: "Aplikasi LMS SMP Serang Baru",
                  initialRoute: Routes.HOME,
                  getPages: AppPages.routes,
                  theme: ThemeData(
                    primarySwatch: Colors.indigo,
                  ),
                );
              } else {
                return _buildErrorScreen('Role pengguna tidak valid.');
              }
            },
          );
        }
      },
    );
  }

  Widget _buildErrorScreen(String message) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Aplikasi LMS SMP Serang Baru",
      home: Scaffold(
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
