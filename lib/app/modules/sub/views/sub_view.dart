import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/input_decorations.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/default_loader.dart';
import '../controllers/sub_controller.dart';

class SubView extends GetView<SubController> {
  const SubView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed(Routes.CREATE_POST),
            child: const Padding(
              padding: EdgeInsets.only(right: 24),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('User name'),
                    GestureDetector(
                      onTap: () async {
                        controller.signOut();
                      },
                      child: const Icon(Icons.logout_outlined),
                    ),
                  ],
                )
              ]),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Obx(() {
          if (controller.isLoaded()) {
            if (controller.posts.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: SafeArea(
                        child: ListView(
                          shrinkWrap: true,
                          children: controller.posts.map((post) {
                            return GestureDetector(
                              onTap: () => Get.toNamed(Routes.DETAIL_POST,
                                  arguments: post.id),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 11),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black87),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Text(
                                  post.title,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('nothing'));
            }
          } else {
            return const DefaultLoader();
          }
        }),
      ),
    );
  }
}
