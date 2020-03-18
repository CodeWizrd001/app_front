import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../DataClasses/Stu.dart';
import 'dart:convert';
import './quizbrain.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'App Front',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title:"Hello")
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Stu> v;

  int _counter = 0;
  Future<Stu> fetchStu() async {
    final response = await http.get('http://127.0.0.1:10000/respond_2');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return Stu.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  var a = <Widget>[Text("Hello"), Text("World"), Text("HelloWorld")];

  void _incrementCounter() {
    setState(() {
      _counter++;
      if(_counter==10)
        v = fetchStu();
    });
  }

  Widget createList() {
    return SafeArea(
      child: Scaffold(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_counter < 10)
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ),
      );
    else
      return SafeArea(
        child: Scaffold(
          body: Column(
            children: <Widget>[
              Center(
                child: FutureBuilder<Stu>(
                  future: v,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(snapshot.data.name);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      );
  }
}

void main() => runApp(Quiz());

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "General Knowledge Quiz",
              style: TextStyle(
                  fontFamily: "Cursive",
                  fontSize: 35,
                  color: Colors.orange.shade900),
            ),
          ),
          body: QuizPage(),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain control = QuizBrain();
  List<Icon> answers = [];
  void checkanswer(bool selectedAns) {
    bool correct = control.correctanswer();
    setState(() {
      if (control.isFinished()) {
        print("Alert");
        /*Alert(
                context: context,
                title: "Quiz Completed!",
                desc: "You Finished the Quiz!")
            .show();*/
        control.resetQuestions();
        answers = [];
      } else {
        if (correct == selectedAns) {
          answers.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          answers.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
      }
      control.next();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                control.getquestion() ,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              child: Text(
                "TRUE",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                checkanswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              child: Text(
                "FALSE",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                checkanswer(false);
              },
            ),
          ),
        ),
        Row(
          children: answers,
        )
      ],
    );
  }
}