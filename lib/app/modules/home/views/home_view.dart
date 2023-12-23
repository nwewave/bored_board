import 'package:boasting_board/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            controller.isLoaded.value
                ? const Text('loadeed')
                : const SizedBox(),
            GestureDetector(
              // onTap: () => Get.toNamed(Routes.SUB),
              onTap: () => Get.toNamed(Routes.SIGNUP),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black87),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Text('Click!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
