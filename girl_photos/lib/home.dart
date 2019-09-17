import 'package:flutter/material.dart';
import 'package:girl_photos/network_tool.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    NetWorkTool().getBaseIP();
    NetWorkTool().getHomeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Center(),
    );
  }
}