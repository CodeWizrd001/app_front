import 'package:flutter/material.dart';
import '../DataClasses/Stu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Fetch extends StatefulWidget {
  final String uri;
  final String port;

  Fetch({
    this.uri,
    this.port,
  });

  @override
  _FetchState createState() {
    print("URI Fetch : $uri");
    return _FetchState(
      uri: uri,
      port: port,
    );
  }
}

class _FetchState extends State<Fetch> {
  final String uri;
  final String port;
  _FetchState({
    this.uri,
    this.port,
  });

  Future<Stu> v;
  Future<Album> c;
  Future<StuList> t;
  List<ListTile> list = [
    ListTile(
      title: Text("Hello"),
    )
  ];

  int a = 0;

  @override
  void initState() {
    super.initState();
    v = fetchStu();
    t = fetchStuList();
  }

  void buildList(StuList t) {
    list = [
      ListTile(
        title: Text(
          "List Of People",
          style: TextStyle(
            color: Colors.teal,
            fontSize: 25,
          ),
        ),
      ),
    ];
    var x = t.length;
    print("BuildList Called $x");
    for (int i = 0; i < x; i += 1) {
      var tmp = t.list[i];
      var x = tmp.name;
      var y = tmp.age;
      var temp = ListTile(
        title: Text(
          "Name : $x  \nAge : $y",
          style: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w800,
          ),
        ),
      );
      list.add(temp);
    }
  }

  Future<Album> fetchAlbum() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/albums/1');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Stu> fetchStu() async {
    print("URI Stu : $uri:$port/respond_2");
    http.Response response;
    try {
      response = await http.get(Uri.http("$uri:$port", "/respond_2"));
    } catch (e) {
      print("Stu $e");
      return Future<Stu>(null);
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return Stu.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<StuList> fetchStuList() async {
    print("URI StuList : $uri:$port/respond");
    http.Response response;
    try {
      response = await http.get(Uri.http("$uri:$port", "/respond"));
    } catch (e) {
      print("StuList $e");
      return Future<StuList>(null);
    }
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return StuList.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          child: FutureBuilder<StuList>(
            future: t,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.error !=
                      "NoSuchMethodError: The method 'call' was called on null.") {
                if (snapshot.data.toString() != null) {
                  buildList(snapshot.data);
                  return Scaffold(
                    backgroundColor: Colors.white70,
                    body: ListView(
                      children: list,
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.black,
                  body: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(100.0),
                            child: Center(
                              child: Text(
                                "Loading...",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.blue,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(100.0),
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
