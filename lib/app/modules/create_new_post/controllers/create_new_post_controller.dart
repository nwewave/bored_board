import 'package:boasting_board/app/common/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/Post.dart';
import '../../../util/logger.dart';
import '../../sub/controllers/sub_controller.dart';

class CreateNewPostController extends GetxController {
  late FirebaseFirestore db;
  final title = RxString("");
  final contents = RxString("");
  late final newPost = Rxn<Post>();
  TextEditingController titleEditCtrl = TextEditingController();
  TextEditingController contentsEditCtrl = TextEditingController();

  @override
  void onInit() {
    db = FirebaseFirestore.instance;
    newPost.value =
        Post(id: '0', title: title.value, contents: contents.value, regDt: '');
    ever(title, (callback) {
      newPost.value?.title = title.value;
    });

    ever(contents, (callback) {
      newPost.value?.contents = contents.value;
    });
    super.onInit();
  }

  Future<bool> postNewPost() async {
    bool result = false;
    if (newPost.value != null) {
      await db
          .collection(POST)
          .withConverter(
            fromFirestore: Post.fromFirestore,
            toFirestore: (Post newPost, options) => newPost.toFirestore(),
          )
          .add(newPost.value!)
          .then((DocumentReference doc) {
        result = true;
        SubController.to.needUpdate.value = true;
      }).catchError((err) {
        dlog.d(
          '##err $err',
        );
      });
    }

    return result;
  }
}
