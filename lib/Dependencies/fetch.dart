import 'package:flutter/material.dart';
import '../DataClasses/Stu.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Fetch extends StatefulWidget {

  final String uri ;

  Fetch({this.uri}) ;

  @override
  _FetchState createState(){
    print("URI Fetch : $uri") ;
    return _FetchState(uri : uri);
  }
}

class _FetchState extends State<Fetch> {

  final String uri ;

  _FetchState({this.uri}) ;
  
  Future<Stu> v;
  Future<Album> c;
  Future<StuList> t ; 

  @override
  void initState() {
    super.initState();
    v = fetchStu() ;
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
    print("URI : $uri") ;
    var response = await http.get(Uri.http("$uri","/respond_2")) ;
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return Stu.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<StuList> fetchStuList() async {
    print("URI : $uri") ;
    var response = await http.get(Uri.http("$uri","/respond")) ;
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
              if (snapshot.hasData ) {
                return Scaffold(
                  body: Text(snapshot.data.toString()),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
