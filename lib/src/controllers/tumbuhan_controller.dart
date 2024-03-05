import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/models/tumbuhan_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TumbuhanController extends GetxController{
  var isLoading = false.obs;
  var id = ''.obs;
  var tumbuhanModels = Rxn<TumbuhanModels>();

  @override
  void onInit(){
    super.onInit();
    getListTumbuhan();
  }

  Future<bool> getListTumbuhan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id.value = prefs.getString('id')!;
    print("ini ID User id.value : ${id.value}");

    try {
      isLoading(true);
      http.Response response = await http
          .get(Uri.tryParse("https://bibit.elasticofsk8.com//api/get_data_tumbuhan?user_id=${id.value}")!, headers: {
        'Cookie': 'ci_session=1497e06dea2d6e0eab463cbd4d9a7efe4d779169'
      });
      
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        isLoading(false);
        if (jsonDecode(response.body)['status'] == true) {
          tumbuhanModels.value = TumbuhanModels.fromJson(jsonDecode(response.body));
          return true;
        } else {
          tumbuhanModels.value = TumbuhanModels.fromJson(jsonDecode(response.body));
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
}