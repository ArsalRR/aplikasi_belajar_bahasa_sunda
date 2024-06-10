import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class VidioPembelajaranController extends GetxController {
   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //TODO: Implement VidioPembelajaranController
  


  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection('materi_vidio');
    return data.orderBy('judul', descending: true).snapshots();
  }
}