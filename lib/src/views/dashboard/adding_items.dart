import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_growth/src/components/buttons.dart';
import 'package:plant_growth/src/components/loadings.dart';
import 'package:plant_growth/src/components/textfield.dart';
import 'package:plant_growth/src/controllers/accounts_controller.dart';
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
  AccountsController accountsController = Get.find();

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
                        Container(
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
                            controller: nameController,
                            hinyText: "Jenis Kelamin Tumbuhan",
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldNameBlack(
                            readOnly: false,
                            iconData: Icons.replay_circle_filled_rounded,
                            controller: nameController,
                            hinyText: "Diameter Batang",
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldNameBlack(
                            readOnly: false,
                            iconData: Icons.height,
                            controller: nameController,
                            hinyText: "Tinggi Tumbuhan",
                          ),
                          const SizedBox(height: 10),
                          CustomTextFieldNameBlackForDescription(
                            readOnly: false,
                            iconData: Icons.notes_rounded,
                            controller: nameController,
                            hinyText: "Deskripsi Tumbuhan",
                          ),
                          Obx(
                            () => kDefaultButtons(
                              backgroundColor: Colors.green,
                              onPressed: accountsController.isLoading.value ? null : (){
                                if(nameController.text.isNotEmpty && genderController.text.isNotEmpty && diameterController.text.isNotEmpty && heightController.text.isNotEmpty && descriptionController.text.isNotEmpty && images != null){

                                }
                              },
                              textColor: Colors.white,
                              title: accountsController.isLoading.value ? "Mengupload..." : "Tambah Tumbuhan"
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
        Obx(() => accountsController.isLoading.value == true
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
        imageQuality: 30,
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
        imageQuality: 30);
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
}