import 'dart:io';

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

  File? _selectedImage;

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
            body: Stack(
              children: [
                SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/bg.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 50),
                        _selectedImage != null ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 4,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(_selectedImage!,fit: BoxFit.cover,)),
                        ) 
                          : Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 5,
                          padding: const EdgeInsets.all(50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.2)
                          ),
                          child: GestureDetector(
                            onTap: ()async{
                              _pickImageGallery();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.7)
                              ),
                              child: Icon(Icons.add),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
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
                        kDefaultButtons(
                          backgroundColor: Colors.green,
                          onPressed: (){},
                          textColor: Colors.white,
                          title: "Tambah Tumbuhan"
                        )
                      ],
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

  Future _pickImageGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(returnedImage == null){
      setState(() {
        _selectedImage = File(returnedImage!.path);
      });
    }
  }

  Future _pickImageCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if(returnedImage == null){
      setState(() {
        _selectedImage = File(returnedImage!.path);
      });
    }
  }
}