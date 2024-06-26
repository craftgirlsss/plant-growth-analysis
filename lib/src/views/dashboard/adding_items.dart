import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_growth/src/components/buttons.dart';
import 'package:plant_growth/src/components/loadings.dart';
import 'package:plant_growth/src/components/textfield.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/controllers/accounts_controller.dart';
import 'package:plant_growth/src/controllers/tumbuhan_controller.dart';
import 'package:plant_growth/src/helpers/focus.dart';

class AddingItemPage extends StatefulWidget {
  const AddingItemPage({super.key});

  @override
  State<AddingItemPage> createState() => _AddingItemPageState();
}

class _AddingItemPageState extends State<AddingItemPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController diameterController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kabupatenController = TextEditingController();
  TextEditingController kecamatanController= TextEditingController();
  TextEditingController desaController = TextEditingController();
  
  AccountsController accountsController = Get.find();
  TumbuhanController tumbuhanController = Get.find();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), ()async{
      if(await tumbuhanController.getAllProvince()){
        print("sukses mendapatkan lokasi");
      };
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    diameterController.dispose();
    heightController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.green.shade50,
                Colors.green.shade100,
                Colors.green.shade200,
                Colors.green.shade300,
              ],
            ),
          ),
          child: GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text("Tambah Data Tumbuhan"),
            ),
            body: Stack(
              children: [
                SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/bg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          images != null
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:
                                Container(
                                  color: Colors.transparent,
                                  width: 100,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(images!)),
                                ),
                              
                          )
                        : 
                        GestureDetector(
                          onTap: () {
                                showActionSheet(context);
                              },
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black54)
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showActionSheet(context);
                              },
                              child: Icon(Icons.add_a_photo_rounded, color: Colors.black54))
                              
                          ),
                        ),
                        const SizedBox(height: 20),
                          images != null ? SizedBox(
                            width: 120,
                            child: kDefaultButtons(
                              onPressed: () {
                                showActionSheet(context);
                              },
                              backgroundColor: Colors.red.shade400,
                              title: "Ubah",
                              textColor: Colors.white
                            ),
                          ) : Container(),
                          const SizedBox(height: 20),
                          CustomTextFieldNameBlack(
                            readOnly: false,
                            iconData: Icons.energy_savings_leaf_rounded,
                            controller: nameController,
                            hinyText: "Nama Tumbuhan",
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldNameBlack(
                            readOnly: false,
                            iconData: Icons.snowing,
                            controller: genderController,
                            hinyText: "Jenis Kelamin Tumbuhan",
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldNameBlack(
                            readOnly: false,
                            iconData: Icons.replay_circle_filled_rounded,
                            controller: diameterController,
                            hinyText: "Diameter Batang (cm)",
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldNameBlack(
                            readOnly: false,
                            iconData: Icons.height,
                            controller: heightController,
                            hinyText: "Tinggi Tumbuhan (meter)",
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: descriptionController,
                            maxLines: 8, //or null 
                            decoration: InputDecoration(
                              fillColor: Colors.black.withOpacity(0.1),
                              filled: true,
                              contentPadding: EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none
                              ),
                              hintText: "Deskripsi tumbuhan"),
                          ),
                          const SizedBox(height: 20),
                          Text("Informasi Wilayah", style: kDefaultTextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black54),),
                          const SizedBox(height: 10),
                          Obx(
                            () => CustomTextFieldNameBlack(
                              readOnly: true,
                              onTap: tumbuhanController.isLoadingPlace.value == true ? null : (){
                                showMyDialogListPlaceProvince(context);
                              },
                              iconData: Icons.place,
                              controller: provinsiController,
                              hinyText: tumbuhanController.isLoadingPlace.value == true ? "Getting Provinsi" : "Provinsi",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => CustomTextFieldNameBlack(
                              readOnly: true,
                              onTap: tumbuhanController.isLoadingPlace.value == true ? null : (){
                                showMyDialogListPlaceKabupaten(context);
                              },
                              iconData: Icons.place,
                              controller: kabupatenController,
                              hinyText: tumbuhanController.isLoadingPlace.value == true ? "Getting Kabupaten" : "Kabupaten",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => CustomTextFieldNameBlack(
                              readOnly: true,
                              onTap: tumbuhanController.isLoadingPlace.value == true ? null : (){
                                showMyDialogListPlaceKecamatan(context);
                              },
                              iconData: Icons.place,
                              controller: kecamatanController,
                              hinyText: tumbuhanController.isLoadingPlace.value == true ? "Getting Kecamatan" : "Kecamatan",
                            ),
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldNameBlack(
                            readOnly: false,
                              iconData: Icons.place,
                              controller: desaController,
                              hinyText: "Desa",
                            ),
                          const SizedBox(height: 30),
                          Obx(
                            () => kDefaultButtons(
                              backgroundColor: Colors.green,
                              onPressed: tumbuhanController.isLoading.value ? null : () async {
                                if(nameController.text.isNotEmpty && genderController.text.isNotEmpty && diameterController.text.isNotEmpty && heightController.text.isNotEmpty && descriptionController.text.isNotEmpty && images != null){
                                  if(await tumbuhanController.tambahDataTumbuhan(
                                    deskripsi: descriptionController.text,
                                    provinsi: provinsiController.text,
                                    kabupaten: kabupatenController.text,
                                    kecamatan: kecamatanController.text,
                                    desa: desaController.text,
                                    diameter: diameterController.text,
                                    jenis_kelamin_tumbuhan: genderController.text,
                                    nama: nameController.text,
                                    tinggi: heightController.text,
                                    urlImage: pathImage
                                  ) == true){
                                    tumbuhanController.getListTumbuhan();
                                    Get.snackbar("Berhasil", "Berhasil menambah data tanaman");
                                    Future.delayed(const Duration(seconds: 2), (){
                                      Navigator.pop(context);
                                    });
                                  }
                                }else{
                                  Get.snackbar("Gagal", "Mohon isi terlebih dahulu data tanaman", backgroundColor: Colors.red, colorText: Colors.white);
                                }
                              },
                              textColor: Colors.white,
                              title: tumbuhanController.isLoading.value ? "Mengupload..." : "Tambah Tumbuhan"
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Obx(() => tumbuhanController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }

  String? pathImage;
  File? images;
  getFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 10,
        preferredCameraDevice: CameraDevice.rear
        );
      setState(() {
        images = File(imagePicked!.path);
        pathImage = imagePicked.path;
      });
  }

  getFromGalleries() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 10);
      setState(() {
        images = File(imagePicked!.path);
        pathImage = imagePicked.path;
      });
  }

  void showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text("Pilih Opsi"),
        message: Text("Pilih opsi pengambilan gambar"),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              await getFromGalleries();
              Navigator.pop(context);
            },
            child: const Text('Gallery', style: TextStyle(color: CupertinoColors.activeBlue),),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
             await getFromCamera();
              Navigator.pop(context);
            },
            child: const Text('Camera', style: TextStyle(color: CupertinoColors.activeBlue)),
          ),
          
        ],
        cancelButton:CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold),),
          ) ,
      ),
    );
  }

  Future<void> showMyDialogListPlaceProvince(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pilih Provinsi'),
        content: Obx(
          () => SizedBox(
            width: 100,
            child: ListView.builder(
              itemBuilder: (context, index) => CupertinoListTile(
                onTap: () async {
                  debugPrint(tumbuhanController.provinsiModels.value?.rajaongkir.results[index].provinceId);
                  setState(() {
                    tumbuhanController.idProvince.value = tumbuhanController.provinsiModels.value!.rajaongkir.results[index].provinceId;
                    provinsiController.text = tumbuhanController.provinsiModels.value!.rajaongkir.results[index].province;
                  });
                  await tumbuhanController.getAllKabupaten();
                  Navigator.pop(context);
                },
                title: Text(tumbuhanController.provinsiModels.value?.rajaongkir.results[index].province ?? 'Unknown')),
              itemCount: tumbuhanController.provinsiModels.value!.rajaongkir.results.length,
            ),
          )
        ),
      );
    },
  );
}

Future<void> showMyDialogListPlaceKabupaten(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pilih Kabupaten'),
        content: Obx(
          () => SizedBox(
            width: 100,
            child: ListView.builder(
              itemBuilder: (context, index) => CupertinoListTile(
                onTap: () async {
                  setState(() {
                    tumbuhanController.idKecamatan.value = tumbuhanController.kabupatenModels.value!.rajaongkir.results[index].cityId!;
                    kabupatenController.text = tumbuhanController.kabupatenModels.value!.rajaongkir.results[index].cityName!;
                  });
                  // debugPrint(tumbuhanController.provinsiModels.value?.rajaongkir.results[index].provinceId);
                  await tumbuhanController.getAllDesa();
                  Navigator.pop(context);
                },
                title: Text(tumbuhanController.kabupatenModels.value?.rajaongkir.results[index].cityName ?? 'Unknown')),
              itemCount: tumbuhanController.kabupatenModels.value!.rajaongkir.results.length,
            ),
          )
        ),
      );
    },
  );
}

Future<void> showMyDialogListPlaceKecamatan(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Pilih Kecamatan'),
        content: Obx(
          () => SizedBox(
            width: 100,
            child: ListView.builder(
              itemBuilder: (context, index) => CupertinoListTile(
                onTap: () async {
                  debugPrint(tumbuhanController.kecamatanModels.value?.rajaongkir.results[index].subdistrictName);
                  setState(() {
                    kecamatanController.text = tumbuhanController.kecamatanModels.value!.rajaongkir.results[index].subdistrictName!;
                  });
                  Navigator.pop(context);
                },
                title: Text(tumbuhanController.kecamatanModels.value?.rajaongkir.results[index].subdistrictName ?? 'Unknown')),
              itemCount: tumbuhanController.kecamatanModels.value!.rajaongkir.results.length,
            ),
          )
        ),
      );
    },
  );
}

}