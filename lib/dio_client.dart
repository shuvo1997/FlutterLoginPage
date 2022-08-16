import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:loginui/models/Post.dart';

class DioClient {
  final Dio dio = Dio();
  static const baseURL = "https://jsonplaceholder.typicode.com";
  static const postsEndpoint = "$baseURL/posts";

  Future<Post> fetchPost(int postId) async {
    try {
      final response = await dio.get("$postsEndpoint/$postId");
      return Post.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint("Status code: ${e.response?.statusCode.toString()}");
      throw Exception("Failed to load post: $postId");
    }
  }

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await dio.get(postsEndpoint);
      var posts = response.data;
      List<Post> listPosts = [];
      for (var post in posts) {
        listPosts.add(Post.fromJson(post));
      }
      return listPosts;
    } on DioError catch (e) {
      debugPrint(e.stackTrace.toString());
      throw Exception('Error in list posts');
    }
  }
}
