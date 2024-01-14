import 'package:boasting_board/app/widgets/default_loader.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../util/toast.dart';
import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  const SigninView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                              SigninController.EMAIL_WARN_CD
                          ? SigninController.EMAIL_WARN
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
                              SigninController.PWD_WARN_CD
                          ? SigninController.PWD_WARN
                          : null),
                  controller: controller.passwordEditCtrl,
                  onChanged: (val) {
                    controller.password.value = val;
                  },
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.SIGNUP),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.bottomCenter,
                    child: const Text(
                      'create new account',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () async {
                      bool result = await controller.signIn();
                      if (result) {
                        basicToast(
                          message: const Text(
                            'welcome!',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                        Get.toNamed(Routes.SUB);
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
