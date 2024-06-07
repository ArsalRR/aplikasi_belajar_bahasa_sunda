import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BhsSundaController extends GetxController {
  var sunda = [].obs;
  var isLoading = false.obs;
  var pesanerror = ''.obs;
  var isDialogShowing = false.obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    isLoading.value = true;
    try {
      var url = Uri.parse('https://hibersunda.onrender.com/undakusukbasa');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data is Map && data.containsKey('words')) {
          sunda.value = data['words'];
        } else {
          pesanerror.value = 'Invalid data format';
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
