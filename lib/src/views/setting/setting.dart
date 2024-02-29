import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/components/alerts.dart';
import 'package:plant_growth/src/components/loadings.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/controllers/accounts_controller.dart';
import 'package:plant_growth/src/helpers/focus.dart';
import 'package:plant_growth/src/views/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'change_password.dart';
import 'myprofile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AccountsController authController = Get.find();

  @override
  void initState() {
    
    super.initState();
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
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/bg.png',
                        fit: BoxFit.cover,
                      )),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          Obx(
                            () => CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.purple,
                              child: Text(
                                authController.accountModels.value!.result.name!.substring(0, 1).toUpperCase(),
                                style: kDefaultTextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => Text(
                              authController.accountModels.value!.result.username!,
                              style: kDefaultTextStyleBold(
                                  fontSize: 19, color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Obx(
                            () => Text(
                              authController.accountModels.value!.result.email!,
                              style: kDefaultTextStyle(
                                  color: Colors.black54, fontSize: 15),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            onTap: () {
                              Get.to(() => const MyProfileDetail());
                            },
                            title: Text(
                              "Informasi Saya",
                              style: kDefaultTextStyle(
                                  fontSize: 17, color: Colors.black87),
                            ),
                            subtitle: Text("Detail Informasi Saya"),
                            leading: Icon(
                              Icons.person,
                              color: Colors.black54,
                            ),
                            trailing: Icon(
                              Icons.arrow_circle_right_sharp,
                              color: Colors.black54,
                            ),
                          ),
                          ListTile(
                            onTap: () => Get.to(() => const ChangePassword()),
                            title: Text(
                              "Ganti Password",
                              style: kDefaultTextStyle(
                                  fontSize: 17, color: Colors.black87),
                            ),
                            subtitle: Text("Ganti kata sandi akun anda"),
                            leading: Icon(
                              Icons.key,
                              color: Colors.black54,
                            ),
                            trailing: Icon(
                              Icons.arrow_circle_right_sharp,
                              color: Colors.black54,
                            ),
                          ),
                          Obx(
                            () => ListTile(
                              onTap: authController.isLoading.value == true ? null : () {
                                AlertDialogCustom.showAlertDialog(context,
                                    onOK: () async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.remove('login');
                                      Navigator.pop(context);
                                      authController.isLoading.value = true;
                                      Future.delayed(const Duration(seconds: 2),(){
                                        authController.isLoading.value = false;
                                        Get.offAll(() => const ViewLogin());
                                      });
                                    });
                              },
                              title: Text(
                                "Keluar",
                                style: kDefaultTextStyle(
                                    fontSize: 17, color: Colors.black87),
                              ),
                              subtitle: Text("Keluar dari akun anda"),
                              leading: Icon(
                                Icons.exit_to_app_sharp,
                                color: Colors.black54,
                              ),
                              trailing: Icon(
                                Icons.arrow_circle_right_sharp,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() => authController.isLoading.value == true
            ? floatingLoading()
            : const SizedBox()),
      ],
    );
  }
}
