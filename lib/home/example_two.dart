
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
// in this screen we created custom own model without using any plugins using get api
  List<Photes> photeslists = [];
  Future<List<Photes>> getPhotes() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photes photes = Photes(title: i["title"], url: i["url"], id: i["id"]);
        photeslists.add(photes);
      }
      return photeslists;
    } else {
      return photeslists;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("example 2"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotes(),
                builder: (context, AsyncSnapshot<List<Photes>> snapshot) {
                  return ListView.builder(
                      itemCount: photeslists.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                snapshot.data![index].url.toString()),
                          ),
                          title: Text(snapshot.data![index].title.toString()),
                          subtitle: Text(snapshot.data![index].id.toString()),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class Photes {
  final String title;
  final String url;
  final int id;
  Photes({required this.title, required this.url, required this.id});
}
