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

  Future<bool> fetchApiClockInWithImage({
    String? nama,
    String? deskripsi,
    String? jenis_kelamin_tumbuhan,
    String? diameter,
    String? tinggi,
    String? urlImage
  }) async {
    var headers = {
      'Cookie': 'ci_session=f1c0ece335067e449b3c359bd0a4e904d2d7f1a5'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://bibit.elasticofsk8.com//api/inputDataTumbuhn'));
    request.fields.addAll({
      'nama': 'Tumbuhan Arfi',
      'deskripsi': 'lorem ipsur sir dolor amet',
      'jenis_kelamin_tumbuhan': 'l',
      'user_id': '1',
      'diameter': '2',
      'tinggi': '2'
    });

    request.files.add(await http.MultipartFile.fromPath('img_file', urlImage!));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      return false;
    }
  }
}