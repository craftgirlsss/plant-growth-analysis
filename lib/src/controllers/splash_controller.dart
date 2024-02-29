import 'package:get/get.dart';
import 'package:plant_growth/src/views/login/login.dart';
import 'package:plant_growth/src/views/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getWasLogin();
  }

  getWasLogin()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? login = prefs.getBool('login');
    if(login == true){
      Future.delayed(const Duration(seconds: 2), (){
        Get.offAll(() => const MainPage());
      });
    }else{
      Future.delayed(const Duration(seconds: 2), (){
        Get.offAll(() => const ViewLogin());
      });
    }
  }
}
