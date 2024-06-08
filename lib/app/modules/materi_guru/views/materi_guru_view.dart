import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/materi_guru_controller.dart';

class MateriGuruView extends GetView<MateriGuruController> {
  const MateriGuruView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Video'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            color: Colors.grey[300],
            width: 200,
            height: 200,
            child: ListTile(
              title: Center(
                child: Icon(
                  Icons.photo_library,
                  size: 70,
                ),
              ),
              onTap: () {},
            ),
          )
        ],
      )),
    );
  }
}
