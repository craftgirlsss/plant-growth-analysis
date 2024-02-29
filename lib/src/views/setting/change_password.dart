import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/components/buttons.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/controllers/accounts_controller.dart';
import 'package:plant_growth/src/helpers/focus.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordv2Controller = TextEditingController();
  AccountsController authController = Get.find();

  @override
  void dispose() {
    passwordController.dispose();
    passwordv2Controller.dispose();
    super.dispose();
  }
  var obscure = false.obs;
  @override
  Widget build(BuildContext context) {
    final passwordField = Obx(
      () => TextFormField(
        controller: passwordController,
        autofocus: false,
        obscureText: obscure.value,
        style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: const Icon(CupertinoIcons.padlock, color: Colors.black54),
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
          hintStyle: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
          hintText: 'Kata Sandi',
          suffixIconColor: Colors.black54,
          suffixIcon: GestureDetector(
            onTap: () {
              obscure.value = !obscure.value;
            },
            child: obscure.value
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

    final passwordFieldv2 = Obx(
      () => TextFormField(
        controller: passwordv2Controller,
        autofocus: false,
        obscureText: obscure.value,
        style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: const Icon(CupertinoIcons.padlock, color: Colors.black54),
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
          hintStyle: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
          hintText: 'Ulangi Kata Sandi',
          suffixIconColor: Colors.black54,
          suffixIcon: GestureDetector(
            onTap: () {
              obscure.value = !obscure.value;
            },
            child: obscure.value
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
                        children: [
                          passwordField,
                          const SizedBox(height: 10),
                          passwordFieldv2,
                          const SizedBox(height: 20),
                          Obx(
                            () => kDefaultButtons(
                              title: "Ubah Password",
                              onPressed: authController.isLoading.value == true ? null : ()async{
                                if(passwordController.text.isNotEmpty && passwordv2Controller.text.isNotEmpty){
                                    if(passwordv2Controller.text != passwordController.text){
                                      Get.snackbar("Gagal", "Kata sandi tidak sama, mohon cek kembali", backgroundColor: Colors.red, colorText: Colors.white);
                                    }else{
                                      if(await authController.changePasswd(
                                        passwordA: passwordController.text,
                                        passwordB: passwordv2Controller.text
                                      ) == true){

                                      }
                                    }
                                }else{
                                  Get.snackbar("Gagal", "Kata sandi tidak boleh kosong", backgroundColor: Colors.red, colorText: Colors.white);
                                }
                                
                              },
                              backgroundColor: Colors.green.withOpacity(0.7)
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
        )
      ],
    );
  }
}
