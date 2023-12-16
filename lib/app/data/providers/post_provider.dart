import 'dart:convert';

import 'package:boasting_board/app/util/logger.dart';
import 'package:http/http.dart' as http;

import '../models/Post.dart';

class PostProvider {
  Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");

  Future<List<Post>> getPosts() async {
    List<Post> posts = [];

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      posts = jsonDecode(response.body).map<Post>((article) {
        return Post.fromMap(article, '');
      }).toList();
    }

    return posts;
  }
}
