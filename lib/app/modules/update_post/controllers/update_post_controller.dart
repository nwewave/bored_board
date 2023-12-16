import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/constants.dart';
import '../../../data/models/Post.dart';
import '../../../util/logger.dart';
import '../../detail_post/controllers/detail_post_controller.dart';
import '../../sub/controllers/sub_controller.dart';

class UpdatePostController extends GetxController {
  late FirebaseFirestore db;
  final title = RxString("");
  final contents = RxString("");
  late final updatedPost = Rxn<Post>();
  TextEditingController titleEditCtrl = TextEditingController();
  TextEditingController contentsEditCtrl = TextEditingController();
  RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    db = FirebaseFirestore.instance;
    await getPost(Get.arguments);
    isLoaded.value = true;
    super.onInit();
  }

  Future<void> getPost(postId) async {
    final docRef = db.collection(POST).doc(postId);
    await docRef.get().then(
      (DocumentSnapshot doc) {
        Post tmpPost =
            Post.fromMap(doc.data() as Map<String, dynamic>?, doc.id);
        title.value = tmpPost.title;
        titleEditCtrl.text = title.value;
        contents.value = tmpPost.contents;
        contentsEditCtrl.text = contents.value;
        updatedPost.value = Post(
            id: doc.id,
            title: title.value,
            contents: contents.value,
            regDt: tmpPost.regDt);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<bool> updateNewPost() async {
    bool result = false;
    if (updatedPost.value != null) {
      final postRef = db.collection(POST).doc(updatedPost.value?.id);
      await postRef.update({
        'title': title.value,
        'contents': contents.value,
      }).then((value) {
        print("DocumentSnapshot successfully updated!");
        result = true;
        DetailPostController.to.getPost(updatedPost.value?.id);
        SubController.to.needUpdate.value = true;
      }, onError: (e) => print("Error updating document $e"));
    }

    return result;
  }
}
