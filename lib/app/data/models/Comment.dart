import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  late String id = '0';
  late String title;
  late String contents;
  late String regDt;

  Comment({
    required this.id,
    required this.title,
    required this.contents,
    required this.regDt,
  });

  Comment.fromMap(Map<String, dynamic>? map, String param_id) {
    id = param_id;
    title = map?['title'] ?? '';
    contents = map?['contents'] ?? '';
    regDt = map?['regDt'] ?? '2023-11-19';
  }

  factory Comment.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Comment(
      id: snapshot.id,
      title: data?['title'],
      contents: data?['contents'],
      regDt: data?['regDt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      "title": title,
      "contents": contents,
      "regDt": regDt,
    };
  }
}
