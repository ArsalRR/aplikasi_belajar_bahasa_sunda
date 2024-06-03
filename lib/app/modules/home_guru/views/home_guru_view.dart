import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_guru_controller.dart';

class HomeGuruView extends GetView<HomeGuruController> {
  const HomeGuruView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeGuruView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HomeGuruView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
