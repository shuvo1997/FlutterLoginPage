import 'package:flutter/material.dart';
import 'package:loginui/models/Post.dart';
import 'dio_client.dart';

class FetchPostsUsingDio extends StatefulWidget {
  const FetchPostsUsingDio({Key? key}) : super(key: key);

  @override
  State<FetchPostsUsingDio> createState() => _FetchPostsUsingDioState();
}

class _FetchPostsUsingDioState extends State<FetchPostsUsingDio> {
  late DioClient dioClient;
  late Future<Post> post;
  late Future<List<Post>> posts;
  late int index;
  bool isRequested = false;

  @override
  void initState() {
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    return isRequested ? selectMethod(index) : buildButton();
  }

  selectMethod(int index) {
    if (index == 0) {
      return buildPost();
    }
    if (index == 1) {
      return buildPosts();
    }
  }

  Widget buildButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                index = 0;
                isRequested = true;
                post = dioClient.fetchPost(1);
              });
            },
            child: const Text('Get A Post')),
        ElevatedButton(
            onPressed: () {
              setState(() {
                index = 1;
                isRequested = true;
                posts = dioClient.fetchPosts();
              });
            },
            child: const Text('Get All posts'))
      ],
    );
  }

  Widget buildPost() {
    return FutureBuilder<Post>(
        future: post,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text('Post Title: ${snapshot.data?.title}',
                      style: const TextStyle(fontSize: 20)),
                  Text('Post Content: ${snapshot.data?.body}'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            throw Exception(snapshot.error);
          }
          return const CircularProgressIndicator();
        });
  }

  Widget buildPosts() {
    return FutureBuilder<List<Post>>(
        future: posts,
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            throw Exception(snapshot.error);
          }
          return const CircularProgressIndicator();
        });
  }
}
