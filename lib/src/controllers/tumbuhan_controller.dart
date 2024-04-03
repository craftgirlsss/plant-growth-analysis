import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/models/detail_tumbuhan_models.dart';
import 'package:plant_growth/src/models/kabupaten_models.dart';
import 'package:plant_growth/src/models/kecamatan_models.dart';
import 'package:plant_growth/src/models/province_models.dart';
import 'package:plant_growth/src/models/tumbuhan_models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TumbuhanController extends GetxController{
  var isLoading = false.obs;
  var isLoadingPlace = false.obs;
  var id = ''.obs;
  var tumbuhanModels = Rxn<TumbuhanModels>();
  var detailTumbuhan = Rxn<DetailTumbuhan>();
  var provinsiModels = Rxn<ProvinsiModels>();
  var kabupatenModels = Rxn<KabupatenModels>();
  var kecamatanModels = Rxn<KecamatanModels>();
  var listProvinsi = [].obs;
  var listKabupaten = [].obs;
  var listKecamatan = [].obs;

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

  Future<bool> tambahDataTumbuhan({
    String? nama,
    String? deskripsi,
    String? jenis_kelamin_tumbuhan,
    String? diameter,
    String? tinggi,
    String? urlImage,
    String? provinsi,
    String? kabupaten,
    String? kecamatan,
    String? desa
  }) async {
    isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id.value = prefs.getString('id')!;
    var headers = {
      'Cookie': 'ci_session=f1c0ece335067e449b3c359bd0a4e904d2d7f1a5'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://bibit.elasticofsk8.com//api/inputDataTumbuhn'));
    request.fields.addAll({
      'nama': nama ?? 'Tidak ada nama',
      'deskripsi': deskripsi ?? 'lorem ipsur sir dolor amet',
      'jenis_kelamin_tumbuhan': jenis_kelamin_tumbuhan ?? 'N/A',
      'user_id': id.value,
      'diameter': diameter ?? '0',
      'tinggi': tinggi ?? '0',
      'provinsi' : provinsi ?? '',
      'kabupaten' : kabupaten ?? '',
      'kecamatan' : kecamatan ?? '',
      'desa' : desa ?? ''
    });

    request.files.add(await http.MultipartFile.fromPath('img_file', urlImage!));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      isLoading(false);
      print(await response.stream.bytesToString());
      return true;
    } else {
      isLoading(false);
      print("gagal upload image status code ${response.statusCode}");
      return false;
    }
  }

  Future<bool> hapusDetailTumbuhan({String? idTumbuhan}) async {
    try {
      isLoading(true);
      http.Response response = await http
          .post(Uri.tryParse("https://bibit.elasticofsk8.com//api/delete_perkembangan_tumbuhan")!, headers: {
        'Cookie': 'ci_session=c40a20994aea49c241b98c3537027072fb04e29f'
      }, body: {
        'id_perkembangan_tumbuhan'   : idTumbuhan
      });
      if (response.statusCode == 200) {
        isLoading(false);
        if (jsonDecode(response.body)['status'] == true) {
          Get.snackbar("Berhasil", jsonDecode(response.body)['message']);
          return true;
        } else {
           Get.snackbar("Gagal", "${jsonDecode(response.body)['message']}");
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

  Future<bool> hapusTumbuhan({String? idTumbuhan}) async {
    try {
      isLoading(true);
      http.Response response = await http
          .post(Uri.tryParse("https://bibit.elasticofsk8.com//api/delete_tumbuhan")!, headers: {
        'Cookie': 'ci_session=c40a20994aea49c241b98c3537027072fb04e29f'
      }, body: {
        'id_tumbuhan'   : idTumbuhan
      });
      if (response.statusCode == 200) {
        isLoading(false);
        if (jsonDecode(response.body)['status'] == true) {
          Get.snackbar("Berhasil", jsonDecode(response.body)['message']);
          await getListTumbuhan();
          return true;
        } else {
           Get.snackbar("Gagal", "${jsonDecode(response.body)['message']}");
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

  Future<bool> tambahDataPerkembangan({
    String? idTumbuhan,
    String? deskripsi,
    String? diameter,
    String? tinggi,
    String? urlImage
  }) async {
    isLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id.value = prefs.getString('id')!;
    var headers = {
      'Cookie': 'ci_session=f1c0ece335067e449b3c359bd0a4e904d2d7f1a5'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://bibit.elasticofsk8.com//api/input_data_perkembangan'));
    request.fields.addAll({
      'deskripsi': deskripsi ?? 'lorem ipsur sir dolor amet',
      'id_tumbuhan': idTumbuhan!,
      'diameter': diameter ?? '0',
      'tinggi': tinggi ?? '0'
    });

    request.files.add(await http.MultipartFile.fromPath('img_file', urlImage!));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      isLoading(false);
      print(await response.stream.bytesToString());
      return true;
    } else {
      isLoading(false);
      print("gagal upload image status code ${response.statusCode}");
      return false;
    }
  }

  Future<bool> getDataTumbuhan({String? id_tumbuhan}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id.value = prefs.getString('id')!;
    print("ini ID User id.value : ${id.value}");
    try {
      isLoading(true);
      http.Response response = await http
          .get(Uri.tryParse("https://bibit.elasticofsk8.com//api/get_detail_tumbuhan?id_tumbuhan=$id_tumbuhan&id_user=${id.value}")!, headers: {
        'Cookie': 'ci_session=1497e06dea2d6e0eab463cbd4d9a7efe4d779169'
      });
      
      if (response.statusCode == 200) {
        print(jsonDecode(response.body));
        isLoading(false);
        if (jsonDecode(response.body)['status'] == true) {
          detailTumbuhan.value = DetailTumbuhan.fromJson(jsonDecode(response.body));
          return true;
        } else {
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

  // API Get nama wilayah indonesia
  
  var idProvince = ''.obs;
  var idKabupaten = ''.obs;
  var idKecamatan = ''.obs;

  Future<bool> getAllProvince() async {
    isLoadingPlace(true);
    var baseUrl = "https://pro.rajaongkir.com/api/province";

    http.Response response = await http.get(Uri.parse(baseUrl),
        headers: {'key': 'e049d10db2bd7fc4d5ec3cb4035633be'});

    if (response.statusCode == 200) {
      isLoadingPlace(false);
      provinsiModels.value = ProvinsiModels.fromJson(jsonDecode(response.body));
      debugPrint("Data provinsi didapatkan");
      return true;
    } else {
      isLoadingPlace(false);
      debugPrint("Gagal mendapatkan data karena status code ${response.statusCode}");
      throw response.statusCode;
    }
  }

  Future<bool> getAllKabupaten() async {
    print(idProvince.value);
    isLoadingPlace(true);
    var baseUrl =
        "https://pro.rajaongkir.com/api/city?province=${idProvince.value}";

    http.Response response = await http.get(Uri.parse(baseUrl),
        headers: {'key': 'e049d10db2bd7fc4d5ec3cb4035633be'});

    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      isLoadingPlace(false);
      kabupatenModels.value = KabupatenModels.fromJson(jsonDecode(response.body));
      debugPrint("Data kabupaten didapatkan");
      return true;
    } else {
      isLoadingPlace(false);
      throw response.statusCode;
    }
  }

  Future<bool> getAllDesa() async {
    isLoadingPlace(true);
    print(idProvince.value);
    var baseUrl =
        "https://pro.rajaongkir.com/api/subdistrict?city=${idKecamatan.value}";

    http.Response response = await http.get(Uri.parse(baseUrl),
        headers: {'key': 'e049d10db2bd7fc4d5ec3cb4035633be'});

    if (response.statusCode == 200) {
      isLoadingPlace(false);
      kecamatanModels.value = KecamatanModels.fromJson(jsonDecode(response.body));
      debugPrint("Data kecamatan didapatkan");
      return true;
    } else {
      isLoadingPlace(false);
      throw response.statusCode;
    }
  }
  
}