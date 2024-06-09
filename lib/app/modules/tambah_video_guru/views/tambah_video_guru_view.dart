import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tambah_video_guru_controller.dart';

class TambahVideoGuruView extends GetView<TambahVideoGuruController> {
  const TambahVideoGuruView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah video guru '),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TambahVideoGuruView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
