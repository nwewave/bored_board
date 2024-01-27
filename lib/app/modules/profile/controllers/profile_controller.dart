import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  late FirebaseFirestore db;
  final name = RxString("");
  late final user = Rxn<User>();
  TextEditingController nameEditCtrl = TextEditingController();

  @override
  Future<void> onInit() async {
    db = FirebaseFirestore.instance;
    await getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? userData) {
      if (userData != null) {
        user.value = userData;
      }
    });
  }

  Future<void> setUser() async {
    await user.value?.updateDisplayName(name.value);
    Get.back();
  }
}
