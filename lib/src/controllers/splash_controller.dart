import 'package:get/get.dart';
import 'package:plant_growth/src/views/login/login.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 4), () {
      Get.to(() => const ViewLogin());
    });
  }
}
