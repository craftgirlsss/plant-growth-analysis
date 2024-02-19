import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_growth/src/components/textstyle.dart';
import 'package:plant_growth/src/helpers/focus.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController passwordController = TextEditingController();
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
          fillColor: Colors.black12,
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
                  // passwordField
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [passwordField],
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
