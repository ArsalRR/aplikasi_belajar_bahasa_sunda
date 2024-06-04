import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isPasswordHidden = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var selectedRole = ''.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void register(String email, String password, String role) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'role': role,
      });
      Get.snackbar(
        'Success',
        'User created successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
      userCredential.user!.sendEmailVerification();
      Get.defaultDialog(
        title: 'Verify your email',
        middleText: 'Please verify your email to continue. We have sent you an email verification link.',
        textConfirm: 'OK',
        textCancel: 'Resend',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.offAllNamed(Routes.LOGIN);
        },
        onCancel: () {
          userCredential.user!.sendEmailVerification();
          Get.snackbar(
            'Success',
            'Email verification link sent',
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 2),
            margin: EdgeInsets.all(12),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          'Error',
          'The password provided is too weak.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(12),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Error',
          'The account already exists for that email.',
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
