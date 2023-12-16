import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/text_style.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/default_dialog.dart';
import '../../../widgets/default_loader.dart';
import '../controllers/detail_post_controller.dart';

class DetailPostView extends GetView<DetailPostController> {
  const DetailPostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.UPDATE_POST,
                arguments: controller.post.value?.id),
            child: const Padding(
              padding: EdgeInsets.only(right: 24),
              child: Icon(Icons.edit),
            ),
          ),
          GestureDetector(
            onTap: () async {
              bool result = await controller.deletePost();
              if (result) {
                showDefaultDialog(
                    title: "deleted!",
                    onTap: () {
                      Get.back();
                      Get.back();
                    });
              } else {
                showDefaultDialog(
                    title: "there's an error",
                    onTap: () {
                      Get.back();
                      Get.back();
                    });
              }
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 24),
              child: Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Obx(() {
          if (controller.isLoaded()) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.post.value!.title,
                        style: title,
                      ),
                      Text(
                        controller.post.value!.regDt,
                        style: subTitle,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 1,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(controller.post()!.contents),
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
