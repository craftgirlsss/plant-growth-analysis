import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AccountsController extends GetxController {
  var isLoading = false.obs;
  // var guruModels = Rxn<GuruModels>();

  Future<bool> loginGuru({String? nip, String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      http.Response response = await http
          .post(Uri.tryParse("http://10.0.2.2/api-mts/auth/login")!, headers: {
        'x_api_key': 'ZjE1ZTEzOTQwNjhhMWQ2ZmQ0Njk4NzVkNmYwMDczMTk'
      }, body: {
        'nip': nip,
        'password': password,
      });

      if (response.statusCode == 200) {
        isLoading(false);
        // print(jsonDecode(response.body));
        if (jsonDecode(response.body)['success'] == true) {
          prefs.setBool('login', true);
          // guruModels.value = GuruModels.fromJson(jsonDecode(response.body));
          Get.snackbar("Berhasil",
              "Berhasil masuk, Anda akan diarahkan ke halaman homepage",
              backgroundColor: Colors.white, colorText: Colors.black87);
          return true;
        } else {
          return false;
        }
      } else {
        // print(response.statusCode);
        isLoading(false);
        return false;
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
      return false;
    }
  }
}
