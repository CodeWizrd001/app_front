import 'package:flutter/material.dart';
import './unimplemented.dart' ;

class MainDrawer extends StatefulWidget {
  final String uName;
  final String uId;
  final String uIn;
  final String uri;
  final String port;

  final List<String> cList = [
    "Club 1",
    "Club 2",
    "Club 3",
    "Club 4",
    "Club 5",
    "Club 6",
  ];

  final List<IconData> icList = [
    Icons.ac_unit,
    Icons.access_alarm,
    Icons.access_time,
    Icons.account_balance,
    Icons.add,
    Icons.add_circle,
    Icons.add_to_photos,
  ];

  MainDrawer({
    this.uName,
    this.uId,
    this.uIn,
    this.uri,
    this.port,
    /*this.cList*/
  });

  @override
  _MainDrawerState createState() => _MainDrawerState(
        uName: "Hello",
        uId: "hello@world.com",
        uIn: "HW",
        cList: cList,
        icList: icList,
        uri: uri,
        port: port,
      );
}

class _MainDrawerState extends State<MainDrawer> {
  final String uName;
  final String uId;
  final String uIn;
  final String uri;
  final String port;
  final List<String> cList;
  final List<IconData> icList;

  static BuildContext bc;

  static void pres() {
    print("Pressed");
  }

  var tScaf = SafeArea(
    child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: pres, label: Text("HelloWorld"))),
  );

  List<Widget> clList = [];
  List<ListTile> iList = [
    ListTile(
      title: Text('Club 1'),
      trailing: Icon(Icons.build),
      onTap: () => Navigator.of(bc).push(
          MaterialPageRoute(builder: (BuildContext context) => Scaffold())),
    ),
    ListTile(
      title: Text('Club 2'),
      trailing: Icon(Icons.airplanemode_active),
      onTap: () => Navigator.of(bc).push(
          MaterialPageRoute(builder: (BuildContext context) => Scaffold())),
    ),
  ];

  _MainDrawerState({
    this.uName,
    this.uId,
    this.uIn,
    this.cList,
    this.icList,
    this.uri,
    this.port,
  });

  void createList(context) {
    print("Drawer $uri:$port");
    clList = [
      UserAccountsDrawerHeader(
        accountName: Text('$uName'),
        accountEmail: Text('$uId'),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.black26,
          child: Text('$uIn'),
        ),
      ),
    ];
    ListTile temp;
    int x;
    int y;
    x = cList.length;
    y = icList.length;
    String tS;
    IconData tI;
    print(x);
    print(y);
    for (int i = 0; i < x; i += 1) {
      tS = cList[i];
      tI = icList[i];
      temp = ListTile(
        title: Text("$tS"),
        trailing: Icon(tI),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Unimplemented() ,
          ),
        ),
      );
      clList.add(temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    createList(context);
    print("ListLength");
    print(clList.length);
    return Drawer(
      child: ListView(
        children: clList,
      ),
    );
  }
}
