import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                controller.setUser();
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text(
                  '저장',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'name',
                ),
                controller: controller.nameEditCtrl,
                onChanged: (val) {
                  controller.name.value = val;
                },
              ),
            ],
          ),
        ));
  }
}
