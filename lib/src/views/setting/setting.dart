import 'package:flutter/material.dart';
import 'package:plant_growth/src/components/textstyle.dart';

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
        SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.red,
                      child: Text(
                        "A",
                        style: kDefaultTextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
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
          ),
        ),
      ],
    );
  }
}
