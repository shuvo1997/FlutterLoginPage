import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loginui/album.dart';

class AlbumFetchExample extends StatefulWidget {
  const AlbumFetchExample({Key? key}) : super(key: key);

  @override
  State<AlbumFetchExample> createState() => _AlbumFetchExampleState();
}

class _AlbumFetchExampleState extends State<AlbumFetchExample> {
  late Future<List<Album>> futureAlbum;

  Future<List<Album>> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/'));

    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body);
      List<Album> albums = List<Album>.from(l.map((e) => Album.fromJson(e)));
      return albums;
      // return Album.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load an Album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Album>>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Album>? albums = snapshot.data;
            return ListView.builder(
                itemCount: albums?.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(albums![index].title),
                      subtitle: Text(albums[index].userId.toString()),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        });
  }
}
