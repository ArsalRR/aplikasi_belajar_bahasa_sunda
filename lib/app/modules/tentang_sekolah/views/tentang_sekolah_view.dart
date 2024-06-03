import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tentang_sekolah_controller.dart';

class TentangSekolahView extends GetView<TentangSekolahController> {
  const TentangSekolahView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TentangSekolahView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TentangSekolahView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
