import 'package:boasting_board/app/common/text_style.dart';
import 'package:boasting_board/app/routes/app_pages.dart';
import 'package:boasting_board/app/widgets/default_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../util/toast.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(19.0),
        height: Get.height,
        width: Get.width,
        color: Colors.transparent,
        child: Obx(() {
          if (controller.isLoaded.value) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: 'email',
                      errorText: controller.warningCd.value ==
                              SignupController.EMAIL_WARN_CD
                          ? SignupController.EMAIL_WARN
                          : null),
                  controller: controller.emailEditCtrl,
                  onChanged: (val) {
                    controller.email.value = val;
                  },
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'password',
                      errorText: controller.warningCd.value ==
                              SignupController.PWD_WARN_CD
                          ? SignupController.PWD_WARN
                          : null),
                  controller: controller.passwordEditCtrl,
                  onChanged: (val) {
                    controller.password.value = val;
                  },
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      // FirebaseAuth.instance.currentUser!
                      //     .sendEmailVerification(); 회원가입 후 파법으로
                      bool result = await controller.signUp();
                      if (result) {
                        basicToast(
                          message: const Text(
                            'signup success!',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                        Get.toNamed(Routes.SIGNIN);
                      }
                    },
                    child: const Text('Send!'),
                  ),
                ),
              ],
            );
          } else {
            return const DefaultLoader();
          }
        }),
      ),
    );
  }
}
