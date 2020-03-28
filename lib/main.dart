import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(TimerApp());

class TimerApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimerAppState();
  }
}

class TimerAppState extends State<TimerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar Flutter',
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => new HomePage(),
        '/TentangKami': (BuildContext context) => new TentangPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  static const duration = const Duration(seconds: 1);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const duration = const Duration(seconds: 1);
  int secondsPassed = 0;
  bool isActive = false;
  Timer timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null)
      timer = Timer.periodic(HomePage.duration, (Timer t) {
        handleTick();
      });

    seconds = secondsPassed % 60;
    minutes = secondsPassed ~/ 60;
    hours = secondsPassed ~/ (60 * 60);

    return MaterialApp(
      title: 'Belajar Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Timer'),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: Text('jerrysibarani@gmail.com'),
                accountName: Text('Jerry Sibarani'),
              ),
              ListTile(
                title: Text("Home"),
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: Text("Tentang Kami"),
                leading: Icon(Icons.work),
                onTap: () {
                  Navigator.pushNamed(context, '/TentangKami');
                },
              )
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextContainer(
                      label: 'HRS', value: hours.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                  CustomTextContainer(
                      label: 'SEC', value: seconds.toString().padLeft(2, '0')),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: RaisedButton(
                  child: Text(isActive ? 'STOP' : 'START'),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TentangPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tetang Kami"),
      ),
      body: new Center(child: new Text('Ini adalah text tentang kami')),
    );
  }
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({this.label, this.value});

  final String label;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(20),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black87,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          )
        ],
      ),
    );
  }
}
