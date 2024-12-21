import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model_class/PostModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //using get apis
  // if we don`t have array name in json then we must declare an empty list for it
  // if we have array name in json then don`t need to create list
  List<PostModel> postsList = [];

  Future<List<PostModel>> GetPosts() async {
    final responce =
    await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map i in data) {
        postsList.add(PostModel.fromJson(i as dynamic));
      }
      return postsList;
    } else {
      return postsList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api`s"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: GetPosts(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: postsList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              "Title : ${postsList[index].title.toString()}",
                              style: TextStyle(fontSize: 19),
                            ),
                            subtitle: Text(
                                "Body : ${postsList[index].body.toString()}"),
                            leading: Text(postsList[index].id.toString()),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
