import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isPasswordHidden = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get streamAuthStatus =>
      FirebaseAuth.instance.authStateChanges();

  Future<User?> getCurrentUser() async {
    return auth.currentUser;
  }

  Future<DocumentSnapshot> getUserData(User user) {
    return firestore.collection('users').doc(user.uid).get();
  }

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null && user.emailVerified) {
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          String role = userDoc['role'];
          Get.snackbar(
            'Berhasil',
            'Sudah Berhasil Login :)',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 2),
            margin: EdgeInsets.all(12),
          );

          if (role == 'Guru') {
            Get.offAllNamed(Routes.HOME_GURU);
          } else if (role == 'Siswa') {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.snackbar(
              'Error',
              'Role pengguna tidak dikenali.',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(12),
            );
          }
        } else {
          Get.snackbar(
            'Error',
            'Data pengguna tidak ditemukan.',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
            margin: EdgeInsets.all(12),
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Email belum diverifikasi. Silakan verifikasi email Anda.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(12),
        );
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan. Silakan coba lagi nanti.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
    }
  }

  void _handleAuthException(FirebaseAuthException e) {
    if (e.code == 'user-not-found') {
      Get.snackbar(
        'Error',
        'Pengguna tidak ditemukan dengan email tersebut.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
    } else if (e.code == 'wrong-password') {
      Get.snackbar(
        'Error',
        'Password yang dimasukkan salah.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
    } else if (e.code == 'too-many-requests') {
      Get.snackbar(
        'Error',
        'Terlalu banyak permintaan. Coba lagi nanti.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
    } else {
      Get.snackbar(
        'Error',
        'Terjadi kesalahan. Silakan coba lagi nanti.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
