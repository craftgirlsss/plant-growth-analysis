import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/components/buttons.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/controllers/accounts_controller.dart';
import 'package:plant_growth/src/views/mainpage.dart';

import '../../components/loadings.dart';
import '../../helpers/focus.dart';

class ViewLogin extends StatefulWidget {
  const ViewLogin({super.key});

  @override
  State<ViewLogin> createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  AccountsController accountsController = Get.put(AccountsController());
  final _keyFormLogin = GlobalKey<FormState>();
  var obsecure = true.obs;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logo = CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 60.0,
      child:
          Hero(tag: 'logo', child: Image.asset('assets/icons/ic_launcher.png')),
    );

    final emailField = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.number,
      autofocus: false,
      style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
      decoration: InputDecoration(
          prefixIcon: const Icon(CupertinoIcons.person, color: Colors.black54),
          filled: true,
          fillColor: Colors.white54,
          hintText: 'Username',
          hintStyle: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(32.0),
          )),
    );

    final passwordField = Obx(
      () => TextFormField(
        controller: passController,
        autofocus: false,
        obscureText: obsecure.value,
        style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: const Icon(CupertinoIcons.padlock, color: Colors.black54),
          fillColor: Colors.white54,
          filled: true,
          hintStyle: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
          hintText: 'Kata Sandi',
          suffixIconColor: Colors.black54,
          suffixIcon: GestureDetector(
            onTap: () {
              obsecure.value = !obsecure.value;
            },
            child: obsecure.value
                ? const Icon(
                    Icons.visibility,
                    color: Colors.black38,
                  )
                : const Icon(
                    Icons.visibility_off_rounded,
                    color: Colors.black38,
                  ),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                32.0,
              )),
        ),
      ),
    );

    return Stack(
      children: [
        GestureDetector(
          onTap: () => focusManager(),
          child: Scaffold(
            backgroundColor: Colors.green.shade600,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Masuk",
                      style: kDefaultTextStyleBold(
                          color: Colors.white, fontSize: 23),
                    ),
                    const SizedBox(height: 70),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height,
                      child: Form(
                        key: _keyFormLogin,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              logo,
                              const SizedBox(height: 10),
                              Hero(
                                tag: "sekolah",
                                child: DefaultTextStyle(
                                  style: kDefaultTextStyleBold(fontSize: 20),
                                  child: const Text(
                                    "Aplikasi Monitoring\nBibit Tumbuhan",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              emailField,
                              const SizedBox(height: 10.0),
                              passwordField,
                              const SizedBox(height: 20),
                              Obx(
                                () => kDefaultButtons(
                                    backgroundColor: Colors.black87,
                                    onPressed:
                                        accountsController.isLoading.value ==
                                                true
                                            ? () {}
                                            : () async {
                                                Get.to(() => const MainPage());
                                                // if (await accountsController
                                                //         .loginGuru(
                                                //             nip: emailController
                                                //                 .text,
                                                //             password: passController
                                                //                 .text) ==
                                                //     true) {
                                                //   Future.delayed(
                                                //       const Duration(seconds: 2),
                                                //       () {
                                                //     Get.to(() => const MainPage());
                                                //   });
                                                // } else {
                                                //   Get.defaultDialog(
                                                //       title: "Gagal",
                                                //       content: const Text(
                                                //           "Gagal menghubungkan ke server"),
                                                //       cancel: TextButton(
                                                //           onPressed: () {
                                                //             Get.back();
                                                //           },
                                                //           child: const Text("OK")));
                                                // }
                                              },
                                    title: accountsController.isLoading.value ==
                                            true
                                        ? "Loading"
                                        : "Masuk"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
}
