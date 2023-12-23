import 'package:boasting_board/app/common/text_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignupView'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(19.0),
        height: Get.height,
        width: Get.width,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'email',
              ),
              controller: controller.emailEditCtrl,
              onChanged: (val) {
                controller.email.value = val;
              },
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'password',
              ),
              controller: controller.passwordEditCtrl,
              onChanged: (val) {
                controller.password.value = val;
              },
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: GestureDetector(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: const Text('다음')),
            )),
      ),
    );
  }
}
