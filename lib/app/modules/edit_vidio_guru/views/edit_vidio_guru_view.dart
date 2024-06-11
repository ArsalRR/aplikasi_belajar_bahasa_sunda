import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_vidio_guru_controller.dart';

class EditVidioGuruView extends GetView<EditVidioGuruController> {
  const EditVidioGuruView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditVidioGuruView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditVidioGuruView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
