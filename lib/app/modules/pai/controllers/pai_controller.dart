import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaiController extends GetxController {
  var pai = [].obs;
  var isLoading = false.obs;
  var pesanerror = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    isLoading.value = true;
    try {
      var url = Uri.parse('https://cors-anywhere.herokuapp.com/https://doa-doa-api-ahmadramadhan.fly.dev/api');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Response Data: $data'); 

        if (data is List) {
          pai.value = data;
        } else {
          pesanerror.value = 'Invalid data format: Expected List but got ${data.runtimeType}';
        }
      } else {
        pesanerror.value = 'Failed to fetch data. Status code: ${response.statusCode}';
      }
    } catch (e) {
      pesanerror.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
