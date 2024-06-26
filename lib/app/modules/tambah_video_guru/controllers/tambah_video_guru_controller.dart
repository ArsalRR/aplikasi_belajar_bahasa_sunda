import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TambahVideoGuruController extends GetxController {
  late TextEditingController judulController;
  late TextEditingController descController;
  late TextEditingController linkytController;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    judulController = TextEditingController();
    descController = TextEditingController();
    linkytController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    judulController.dispose();
    descController.dispose();
    linkytController.dispose();
    super.onClose();
  }

  void addData(String judul, String link, String desc) async {
    QuickAlert.show(
      context: Get.context!,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Menyimpan data...',
    );

    try {
      await firestore.collection('materi_vidio').add({
        'judul': judul,
        'link': link,
        'desc': desc,
      });

      judulController.clear();
      descController.clear();
      linkytController.clear();
      Get.back();
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.success,
        title: 'Berhasil',
        text: 'Data Berhasil Disimpan',
      );

      await Future.delayed(Duration(seconds: 2));
      Get.back();

      _showNotification(judul);
    } catch (e) {
      print(e);

      Get.back();

      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.error,
        title: 'Gagal',
        text: 'Gagal Tambah data: $e',
      );
    }
  }

  Future<void> _showNotification(String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', 'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Vidio Baru',
      title,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
