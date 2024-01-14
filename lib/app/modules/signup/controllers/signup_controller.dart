import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/firebase_service.dart';
import '../../../routes/app_pages.dart';
import '../../../util/logger.dart';
import '../../../util/toast.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.find();
  RxBool isLoaded = false.obs;
  final email = RxString("");
  final password = RxString("");

  TextEditingController emailEditCtrl = TextEditingController();
  TextEditingController passwordEditCtrl = TextEditingController();

  final warningStr = RxString('');
  final warningCd = RxString('');
  static const PWD_WARN_CD = 'weak-password';
  static const EMAIL_WARN_CD = 'email-already-in-use';
  static const PWD_WARN = 'The password provided is too weak.';
  static const EMAIL_WARN = 'The account already exists for that email.';

  @override
  Future<void> onInit() async {
    isLoaded(true);
    super.onInit();
  }

  Future<bool> signUp() async {
    isLoaded(false);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      print(credential);
      isLoaded(true);
      return true;
    } on FirebaseAuthException catch (e) {
      warningCd.value = e.code;
      if (e.code == PWD_WARN_CD) {
        warningStr.value = PWD_WARN;
      } else if (e.code == EMAIL_WARN_CD) {
        warningStr.value = EMAIL_WARN;
      }
      isLoaded(true);
      return false;
    } catch (e) {
      errorToast(e.toString());
      isLoaded(true);
      return false;
    }
  }
}
