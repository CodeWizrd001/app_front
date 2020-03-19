import 'dart:convert';

import 'package:flutter/material.dart';
import '../DataClasses/Stu.dart';
import 'package:http/http.dart' as http;

class Send extends StatefulWidget {
  final String uri;
  final String port;

  Send({
    this.uri,
    this.port,
  });

  @override
  _SendState createState() => _SendState(uri: uri,port: port);
}

class _SendState extends State<Send> {
  final String uri;
  final String port;

  var nameCont = TextEditingController();
  var ageCont = TextEditingController();

  _SendState({
    this.uri,
    this.port,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Name"),
                    controller: nameCont,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Age"),
                    controller: ageCont,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    child: Text("Enter"),
                    onPressed: () {
                      print(nameCont.text);
                      print(ageCont.text);
                      if (nameCont.text != "" && ageCont.text != "") {
                        var data = Stu(
                          name: nameCont.text,
                          age: int.parse(ageCont.text) ,
                        );
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SendData(
                              uri: uri,
                              port: port,
                              data: data,
                            ),
                          ),
                        );
                      } 
                      else
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SafeArea(
                              child: Scaffold(
                                backgroundColor: Colors.black,
                                body: Center(
                                  child: Text(
                                    "Enter All Info",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SendData extends StatefulWidget {
  final String uri;
  final String port;
  final Stu data;

  SendData({
    this.uri,
    this.port,
    this.data,
  });

  @override
  _SendDataState createState() => _SendDataState(uri: uri,port:port,data: data);
}

class _SendDataState extends State<SendData> {
  final String uri;
  final String port;
  final Stu data;

  _SendDataState({
    this.uri,
    this.port,
    this.data,
  });

  Future<Stu> t;

  Future<Stu> sendData() async {
    print("Sending Request $uri:$port") ;
    final http.Response response = await http.post(
      Uri.http("$uri:$port", "/add"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': data.name,
        'age': data.age.toString(),
      }),
    );
    if (response.statusCode == 200) {
      return Stu.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Came Here") ;
    t = sendData();
    return SafeArea(
      child: FutureBuilder<Stu>(
        future: t,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.name);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
