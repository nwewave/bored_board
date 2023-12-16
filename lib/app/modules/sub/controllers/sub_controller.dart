import 'package:boasting_board/app/common/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/Post.dart';

class SubController extends GetxController {
  late FirebaseFirestore db;
  RxBool isLoaded = false.obs;
  final posts = RxList<Post>();
  final needUpdate = RxBool(false);
  static SubController get to => Get.find();

  Future<void> getPosts() async {
    posts.clear();
    await db.collection(POST).get().then((event) {
      for (var doc in event.docs) {
        final newPost = Post.fromMap(doc.data(), doc.id);
        posts.add(newPost);
      }
    });
  }

  @override
  Future<void> onInit() async {
    db = FirebaseFirestore.instance;
    await getPosts();
    isLoaded.value = true;
    super.onInit();
  }

  @override
  void onReady() {
    ever(needUpdate, (callback) async {
      if (needUpdate()) {
        await getPosts();
        needUpdate.value = false;
      }
    });
    super.onReady();
  }
}
