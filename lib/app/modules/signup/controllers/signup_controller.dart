import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/firebase_service.dart';
import '../../../routes/app_pages.dart';
import '../../../util/logger.dart';
import '../../../util/toast.dart';

class SignupController extends GetxController {
  static SignupController get to => Get.find();

  final email = RxString("");
  final password = RxString("");

  TextEditingController emailEditCtrl = TextEditingController();
  TextEditingController passwordEditCtrl = TextEditingController();
}
