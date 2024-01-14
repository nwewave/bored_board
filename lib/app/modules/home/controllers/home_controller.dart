import 'package:boasting_board/app/data/providers/post_provider.dart';
import 'package:boasting_board/app/util/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeController extends GetxController {
  RxBool isLoaded = false.obs;
  RxBool hasUser = false.obs;

  @override
  Future<void> onInit() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        hasUser.value = true;
        print(user);
      }
    });
    isLoaded.value = true;
    super.onInit();
  }
}
