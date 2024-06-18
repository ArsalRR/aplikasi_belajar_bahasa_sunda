import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

class RegisterController extends GetxController {
  var isPasswordHidden = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  var selectedRole = ''.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void register(String email, String password, String nama, String role) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'nama': nama,
        'role': role,
      });
      
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'User created successfully. Please verify your email to continue.',
        confirmBtnText: 'OK',
        onConfirmBtnTap: () {
          userCredential.user!.sendEmailVerification();
          Get.offAllNamed(Routes.LOGIN);
        },
        cancelBtnText: 'Resend',
        onCancelBtnTap: () {
          userCredential.user!.sendEmailVerification();
          QuickAlert.show(
            context: Get.context!,
            type: QuickAlertType.success,
            title: 'Success',
            text: 'Email verification link sent',
            confirmBtnText: 'OK',
          );
        },
      );

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'The password provided is too weak.',
          confirmBtnText: 'OK',
        );
      } else if (e.code == 'email-already-in-use') {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'The account already exists for that email.',
          confirmBtnText: 'OK',
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
    fullNameController.dispose();
    super.onClose();
  }
}
