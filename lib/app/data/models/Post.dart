import 'package:cloud_firestore/cloud_firestore.dart';

import '../../util/logger.dart';

class Post {
  late String id = '0';
  late String title;
  late String contents;
  late String regDt;
  late String author;

  Post({
    required this.id,
    required this.title,
    required this.contents,
    required this.regDt,
    required this.author,
  });

  Post.fromMap(Map<String, dynamic>? map, String param_id) {
    dlog.d(
      '##map $map',
    );
    id = param_id;
    title = map?['title'] ?? '';
    contents = map?['contents'] ?? '';
    regDt = map?['regDt'] ?? '2023-11-19';
    regDt = map?['author'] ?? 'author';
  }

  factory Post.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Post(
      id: snapshot.id,
      title: data?['title'],
      contents: data?['contents'],
      regDt: data?['regDt'],
      author: data?['author'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      "title": title,
      "contents": contents,
      "regDt": regDt,
      "author": author,
    };
  }
}
