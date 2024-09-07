import 'package:get/get.dart';
import 'package:practicaltest/ui/home/home_controller.dart';
import 'package:practicaltest/app/service/network_service.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NetworkController>(() => NetworkController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
