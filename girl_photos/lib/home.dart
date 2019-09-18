import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:girl_photos/details.dart';
import 'package:girl_photos/network_tool.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _sourceData = [];
  int _index = 1;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getHomeList();
    _controller.addListener(moreListData);
  }

  void getHomeList() async {
    List data = await NetWorkTool().getHomeList(_index);
    if (_index == 1) {
      _sourceData = [];
      print(data);
    }
    setState(() {
      _sourceData.addAll(data);
    });
  }

  //  加载更多
  void moreListData() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        _index += 1;
        getHomeList();
      });
    }
  }

  // 上拉刷新
  void _handlerRefresh() {
    setState(() {
      _index = 1;
      getHomeList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: RefreshIndicator(
          onRefresh: () {},
          child: new StaggeredGridView.countBuilder(
            controller: _controller,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            padding: EdgeInsets.all(8),
            crossAxisCount: 4,
            itemCount: _sourceData.length,
            itemBuilder: (BuildContext context, int index) {
              return PhotoView(_sourceData[index]);
            }, //返回的组件即为每个item。
            staggeredTileBuilder: (index) => StaggeredTile.fit(2), //
          )),
    );
  }
}

class PhotoView extends StatelessWidget {
  ListModel model;
  PhotoView(this.model);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          children: <Widget>[
            Image.network(
              "${model.photos[0].url}",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 3.0,
            ),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(model.girl.avatar),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "${model.girl.name}   ${model.content} ",
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.0,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailsView(model)));
      },
    );
  }
}
