import 'package:get/get.dart';

import '../controllers/create_new_post_controller.dart';

class CreateNewPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNewPostController>(
      () => CreateNewPostController(),
    );
  }
}
