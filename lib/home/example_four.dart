import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  // when plugin cant create a model class due some issues
  // i.e spacing problem in parameters (fulladdress to full address )in json
  var data;
  Future<void> Getuser() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example 4"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: Getuser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: Column(
                            children: [
                              ReuseRow(
                                  title: "Name",
                                  value: data[index]['name'].toString()),
                              ReuseRow(
                                  title: "Address",
                                  value: data[index]["address"]["street"]
                                      .toString()),
                              ReuseRow(
                                  title: "lat",
                                  value: data[index]["address"]["geo"]["lat"]
                                      .toString()),
                              ReuseRow(
                                  title: "lng",
                                  value: data[index]["address"]["geo"]["lng"]
                                      .toString())
                            ],
                          ));
                        });
                  }
                }),
          )
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
