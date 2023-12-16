import 'package:boasting_board/app/common/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/Post.dart';
import '../../sub/controllers/sub_controller.dart';

class DetailPostController extends GetxController {
  RxBool isLoaded = false.obs;
  late FirebaseFirestore db;
  final post = Rxn<Post>();
  static DetailPostController get to => Get.find();

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
        post.value = Post.fromMap(doc.data() as Map<String, dynamic>?, doc.id);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<bool> deletePost() async {
    bool result = false;
    await db.collection(POST).doc(post()?.id).delete().then(
      (doc) {
        print("Document deleted");
        result = true;
        SubController.to.needUpdate.value = true;
      },
      onError: (e) => print("Error updating document $e"),
    );
    return result;
  }
}
