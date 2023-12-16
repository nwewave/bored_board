import 'package:boasting_board/app/data/providers/post_provider.dart';
import 'package:boasting_board/app/util/logger.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  RxBool isLoaded = false.obs;

  @override
  Future<void> onInit() async {
    isLoaded.value = true;
    super.onInit();
  }
}
