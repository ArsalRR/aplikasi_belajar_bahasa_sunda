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

  Stream<User?> get streamAuthStatus => FirebaseAuth.instance.authStateChanges();

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user!.emailVerified) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();
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
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.snackbar(
          'Error',
          'Please verify your email',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(12),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('wrong email');
        Get.snackbar(
          'Error',
          'No user found for that email.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(12),
        );
      } else if (e.code == 'wrong-password') {
        print('wrong password');
        Get.snackbar(
          'Error',
          'Wrong password provided for that user.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(12),
        );
      } else if (e.code == 'too-many-requests') {
        print('too-many-requests');
        Get.snackbar(
          'Error',
          'Too many requests. Try again later.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(12),
        );
      }
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
