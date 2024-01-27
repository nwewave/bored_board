import 'package:boasting_board/app/common/constants.dart';
import 'package:boasting_board/app/routes/app_pages.dart';
import 'package:boasting_board/app/util/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/Post.dart';
import '../../../util/logger.dart';
import '../../../widgets/default_dialog.dart';

class SubController extends GetxController {
  late FirebaseFirestore db;
  RxBool isLoaded = false.obs;
  final posts = RxList<Post>();
  late final user = Rxn<User>();
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

  Future<void> getUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? userData) {
      if (userData != null) {
        user.value = userData;
      }
    });
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAndToNamed(Routes.HOME);
    } catch (e) {
      errorToast(e.toString());
    }
  }

  @override
  Future<void> onInit() async {
    db = FirebaseFirestore.instance;
    await getPosts();
    await getUser();
    isLoaded.value = true;
    dlog.d(
      '##user.value ${user.value}',
    );
    if (user.value?.displayName == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDefaultDialog(
            title: "You don't have your name yet.",
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            });
      });
    }
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
