import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:plant_growth/src/models/accounts_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountsController extends GetxController {
  var isLoading = false.obs;
  var accountModels= Rxn<AccountModels>();
  var id = ''.obs;

  Future<bool> changePasswd({String? passwordA, String? passwordB}) async {
    try {
      isLoading(true);
      http.Response response = await http
          .post(Uri.tryParse("http://10.0.2.2/api-mts/auth/login")!, headers: {
        'Cookie': 'ci_session=1497e06dea2d6e0eab463cbd4d9a7efe4d779169'
      }, body: {
        'email'        : accountModels.value?.result.email,
        'password_lama': passwordA,
        'password_baru': passwordB
      });
      if (response.statusCode == 200) {
        isLoading(false);
        if (jsonDecode(response.body)['success'] == true) {
          Get.snackbar("Berhasil",
              "Berhasil merubah kata sandi",
              backgroundColor: Colors.white, colorText: Colors.black87);
          return true;
        } else {
           Get.snackbar("Gagal", "${jsonDecode(response.body)['message']}", backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
      } else {
        isLoading(false);
        return false;
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> login({String? username, String? password}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      isLoading(true);
      http.Response response = await http
          .post(Uri.tryParse("https://bibit.elasticofsk8.com//api/login")!, headers: {
        'Cookie': 'ci_session=1497e06dea2d6e0eab463cbd4d9a7efe4d779169'
      }, body: {
        'username': username ?? '',
        'password': password ?? ''
      });

      if (response.statusCode == 200) {
        isLoading(false);
        if (jsonDecode(response.body)['status'] == true) {
          prefs.setBool('login', true);
          prefs.setString('id', jsonDecode(response.body)['result']['id']);
          accountModels.value = AccountModels.fromJson(jsonDecode(response.body));
          Get.snackbar("Berhasil",
              "Berhasil masuk, Anda akan diarahkan ke halaman homepage",
              backgroundColor: Colors.white, colorText: Colors.black87);
          return true;
        } else {
          Get.snackbar("Gagal", "${jsonDecode(response.body)['message']}", backgroundColor: Colors.red, colorText: Colors.white);
          return false;
        }
      } else {
        isLoading(false);
        return false;
      }
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> getPersonalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id.value = prefs.getString('id')!;
    print("ini ID User id.value : ${id.value}");
    try {
      isLoading(true);
      http.Response response = await http
          .post(Uri.tryParse("https://bibit.elasticofsk8.com//api/get_profile?user_id=${id.value}")!, headers: {
        'Cookie': 'ci_session=1497e06dea2d6e0eab463cbd4d9a7efe4d779169'
      });
      if (response.statusCode == 200) {
        isLoading(false);
        if (jsonDecode(response.body)['status'] == true) {
          accountModels.value = AccountModels.fromJson(jsonDecode(response.body));
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
