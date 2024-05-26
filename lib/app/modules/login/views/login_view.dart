import 'package:capstone_project/app/modules/login/controllers/login_controller.dart';
import 'package:capstone_project/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(height: 50),
            Center(
              child: Image.asset(
                'assets/img/std.png',
                height: 200,
              ),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Masukkan Email anda',
                      labelStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 20),
                  Obx(() => TextField(
                    obscureText: controller.isPasswordHidden.value,
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Masukkan Password anda',
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordHidden.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          controller.isPasswordHidden.value =
                              !controller.isPasswordHidden.value;
                        },
                      ),
                    ),
                  )),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                Get.toNamed(Routes.RESET_PASSWORD);
                      },
                      child: Text(
                        'Lupa Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff008DDA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (controller.emailController.text.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Email tidak boleh kosong',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } else if (controller.passwordController.text.isEmpty) {
                          Get.snackbar(
                            'Error',
                            'Password tidak boleh kosong',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } else {
                          controller.login(
                            controller.emailController.text,
                            controller.passwordController.text,
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 50,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Color(0xff008DDA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff008DDA),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.REGISTER);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
