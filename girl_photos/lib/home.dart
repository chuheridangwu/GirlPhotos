import 'package:flutter/material.dart';
import 'package:girl_photos/network_tool.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _sourceData = ['1', '2', '3', '3', '2', '5'];

  @override
  void initState() {
    super.initState();
    // NetWorkTool().getBaseIP();
    // NetWorkTool().getHomeList();
    // NetWorkTool().getLatestList();
    // NetWorkTool().getRankingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Container(
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          children: _sourceData.map((item){
            return Container(
              color: Colors.red,
              child: Text('$item'),
            );
          }).toList(),
        )
      ),
    );
  }
}

class PhotoView extends StatelessWidget {
  String title;
  PhotoView(this.title);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Colors.red,
        child: Column(
          children: <Widget>[
            Text(title),
          ],
        ),
      ),
    );
  }
}
