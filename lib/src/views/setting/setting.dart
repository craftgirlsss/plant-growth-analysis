import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/components/alerts.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/helpers/focus.dart';

import 'change_password.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.purple,
                            child: Text(
                              "A",
                              style: kDefaultTextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Nama Pengguna",
                            style: kDefaultTextStyleBold(
                                fontSize: 19, color: Colors.black),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "email@email.com",
                            style: kDefaultTextStyle(
                                color: Colors.black54, fontSize: 15),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
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
                          ListTile(
                            onTap: () {
                              AlertDialogCustom.showAlertDialog(context,
                                  onOK: () {});
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
