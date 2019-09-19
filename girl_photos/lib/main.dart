import 'package:flutter/material.dart';
import 'package:girl_photos/home.dart';
import 'package:girl_photos/latest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(
                  text: 'home',
                ),
                Tab(
                  text: 'latest',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              HomePage(),
              LatestView()
            ],
          ),
        ),
      )
    );
  }
}