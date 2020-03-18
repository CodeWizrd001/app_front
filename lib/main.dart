import 'package:app_front/Dependencies/fetch.dart';
import 'package:flutter/material.dart';
import './Dependencies/drawer.dart';
import './Dependencies/card.dart';
import 'package:ussd/ussd.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: Greet(),
    );
  }
}

class MyApp extends StatefulWidget {
  final String uri;

  MyApp({this.uri});

  @override
  _MyAppState createState() => _MyAppState(uri: uri);
}

class _MyAppState extends State<MyApp> {
  final String uri;

  _MyAppState({this.uri});

  Future<void> launchUssd(String ussdCode) async {
    Ussd.runUssd(ussdCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("New App"),
          ),
          drawer: MainDrawer(uri: uri,),
          body: Column(
            children: <Widget>[
              Card(
                child: Text("Hello"),
              ),
              Card(
                child: Text("World"),
              ),
              MyCard(
                name: "Hello",
                roll: "World",
                age: 19,
              ),
              RaisedButton(
                child: Text("Fetch"),
                onPressed: () {
                  print("Pressed");
                  return Fetch(uri: uri);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Greet extends StatefulWidget {
  @override
  _GreetState createState() => _GreetState();
}

class _GreetState extends State<Greet> {
  var cont = TextEditingController();

  @override
  void dispose() {
    cont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Center(
                  child: Text("Enter URI"),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Enter URI"),
                    controller: cont,
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
                    onPressed: ()
                    {
                      print(cont.text) ;
                      return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyApp(
                          uri: cont.text,
                        ),
                      ),
                    ) ;
                    }
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
