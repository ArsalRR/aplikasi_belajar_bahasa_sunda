import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_materi_vidio_guru_controller.dart';

class UpdateMateriVidioGuruView
    extends GetView<UpdateMateriVidioGuruController> {
  const UpdateMateriVidioGuruView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpdateMateriVidioGuruView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'UpdateMateriVidioGuruView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
