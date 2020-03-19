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
  final String port;

  MyApp({
    this.uri,
    this.port,
  });

  @override
  _MyAppState createState() => _MyAppState(
        uri: uri,
        port: port,
      );
}

class _MyAppState extends State<MyApp> {
  final String uri;
  final String port;

  _MyAppState({
    this.uri,
    this.port,
  });

  Future<void> launchUssd(String ussdCode) async {
    Ussd.runUssd(ussdCode);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("New App"),
        ),
        drawer: MainDrawer(
          uri: uri,
          port: port,
        ),
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
                return Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Fetch(
                      uri: uri,
                      port: port,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // ),
    );
  }
}

class Greet extends StatefulWidget {
  @override
  _GreetState createState() => _GreetState();
}

class _GreetState extends State<Greet> {
  var uriCont = TextEditingController();
  var portCont = TextEditingController();

  @override
  void dispose() {
    uriCont.dispose();
    portCont.dispose();
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
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Enter URI"),
                    controller: uriCont,
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Enter Port"),
                    controller: portCont,
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
                      print(uriCont.text);
                      print(portCont.text);
                      if (uriCont.text != "" && portCont.text != "")
                        return Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MyApp(
                              uri: uriCont.text,
                              port: portCont.text,
                            ),
                          ),
                        );
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
