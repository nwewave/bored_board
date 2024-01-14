import 'package:boasting_board/app/modules/sub/controllers/sub_controller.dart';
import 'package:get/get.dart';

import '../../signin/controllers/signin_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
