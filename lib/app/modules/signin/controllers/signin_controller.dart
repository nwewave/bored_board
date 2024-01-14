import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  RxBool isLoaded = false.obs;
  final email = RxString("");
  final password = RxString("");

  TextEditingController emailEditCtrl = TextEditingController();
  TextEditingController passwordEditCtrl = TextEditingController();

  final warningStr = RxString('');
  final warningCd = RxString('');
  static const PWD_WARN_CD = 'wrong-password';
  static const EMAIL_WARN_CD = 'user-not-found';
  static const PWD_WARN = 'Wrong password provided for that user.';
  static const EMAIL_WARN = 'No user found for that email.';

  @override
  Future<void> onInit() async {
    isLoaded(true);
    super.onInit();
  }

  Future<bool> signIn() async {
    isLoaded(false);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.value, password: password.value);
      isLoaded(true);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == EMAIL_WARN_CD) {
        warningStr.value = EMAIL_WARN;
      } else if (e.code == PWD_WARN_CD) {
        warningStr.value = PWD_WARN;
      }
      isLoaded(true);
      return false;
    }
  }
}
