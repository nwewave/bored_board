import 'package:get/get.dart';

import '../controllers/sub_controller.dart';

class SubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubController>(
      () => SubController(),
    );
  }
}
