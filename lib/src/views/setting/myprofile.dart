import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/components/textfield.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/controllers/accounts_controller.dart';
import 'package:plant_growth/src/helpers/focus.dart';

class MyProfileDetail extends StatefulWidget {
  const MyProfileDetail({super.key});

  @override
  State<MyProfileDetail> createState() => _MyProfileDetailState();
}

class _MyProfileDetailState extends State<MyProfileDetail> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  AccountsController authController = Get.find();

  @override
  void initState() {
    namaController.text = authController.accountModels.value?.result.name ?? 'Unknown';
    emailController.text = authController.accountModels.value?.result.email ?? 'Email tidak diset';
    idController.text = authController.accountModels.value?.result.id ?? '0';
    alamatController.text = "Surabaya";
    super.initState();
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    idController.dispose();
    alamatController.dispose();
    super.dispose();
  }
  var obscure = false.obs;
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
                title: Text("Ganti Password", style: kDefaultTextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                backgroundColor: Colors.green.withOpacity(0.1),
                elevation: 0,
                centerTitle: true,
              ),
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/bg.png',
                        fit: BoxFit.cover,
                      )),
                  // passwordField
                  SafeArea(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("ID Akun", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          CustomTextFieldName(
                            iconData: Icons.numbers_rounded,
                            controller: idController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 10),
                          Text("Nama", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          CustomTextFieldName(
                            iconData: Icons.person,
                            controller: namaController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 10),
                          Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          CustomTextFieldName(
                            iconData: Icons.mail,
                            controller: emailController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 10),
                          Text("Alamat", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          CustomTextFieldName(
                            iconData: Icons.location_on,
                            controller: alamatController,
                            readOnly: true,
                          ),
                          const SizedBox(height: 10),
                          ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
