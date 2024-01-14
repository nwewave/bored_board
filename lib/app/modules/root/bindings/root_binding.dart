import 'package:boasting_board/app/modules/home/controllers/home_controller.dart';
import 'package:boasting_board/app/modules/sub/controllers/sub_controller.dart';
import 'package:get/get.dart';

import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SubController>(
      () => SubController(),
    );
  }
}
