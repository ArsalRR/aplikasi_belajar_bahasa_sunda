import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone_project/app/modules/login/controllers/login_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(apiKey: "AIzaSyATHaKgPOBKm7puAv132W6BxPj7Dy5D-Rs", appId:"1:790355774790:android:a0d7d3026b1e4097956947" , messagingSenderId: "790355774790", projectId: "my-project-f34c5")
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(LoginController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authC.streamAuthStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            print(snapshot);
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Aplikasi LMS SMP Serang Baru",
              initialRoute:
                  snapshot.data != null && snapshot.data!.emailVerified == true
                      ? Routes.HOME
                      : Routes.LOGIN,
              getPages: AppPages.routes,
              theme: ThemeData(
                primarySwatch: Colors.indigo,
              ),
            );
          }
          return LoadingView();
        });
  }
}
