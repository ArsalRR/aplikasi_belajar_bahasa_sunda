import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tugas_detail_controller.dart';

class TugasDetailView extends GetView<TugasDetailController> {
  const TugasDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TugasDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TugasDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
