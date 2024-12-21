import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model_class/UserModel.dart';

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  // here we will work with complex json using get apis
  List<UserModel> userlist = [];
  Future<List<UserModel>> GetUsers() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userlist.add(UserModel.fromJson(i as dynamic));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example 3"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: GetUsers(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: userlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                ReuseRow(
                                    title: "Name",
                                    value:
                                        snapshot.data![index].name.toString()),
                                ReuseRow(
                                    title: "Address",
                                    value: snapshot.data![index].address
                                        .toString()),
                                ReuseRow(
                                    title: "city",
                                    value: snapshot.data![index].address!.city
                                        .toString()),
                                ReuseRow(
                                    title: "geo",
                                    value: snapshot
                                        .data![index].address!.geo!.lat
                                        .toString())
                              ],
                            ),
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

class ReuseRow extends StatelessWidget {
  final String title, value;
  const ReuseRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
