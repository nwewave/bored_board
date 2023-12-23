import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../util/logger.dart';
import '../../../widgets/default_dialog.dart';
import '../controllers/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'title',
                ),
                controller: controller.titleEditCtrl,
                onChanged: (val) {
                  controller.title.value = val;
                },
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'contents',
                ),
                controller: controller.contentsEditCtrl,
                onChanged: (val) {
                  controller.contents.value = val;
                },
                maxLines: 6,
                keyboardType: TextInputType.multiline,
              ),
              Container(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black12,
                  ),
                  onPressed: () async {
                    bool result = await controller.postNewPost();

                    if (result) {
                      showDefaultDialog(
                          title: "succeed!",
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
                  child: const Text('Send!'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }
}
