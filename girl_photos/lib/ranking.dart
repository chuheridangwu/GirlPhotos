import 'package:flutter/material.dart';
import 'package:girl_photos/details.dart';
import 'package:girl_photos/network_tool.dart';

class RankingView extends StatefulWidget {
  @override
  _RankingViewState createState() => _RankingViewState();
}

class _RankingViewState extends State<RankingView> {
  List _dataSource = [];
  int _index = 1;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    getRankingList();
    _controller.addListener(moreDataSource);
  }

  void getRankingList() async {
    List data = await NetWorkTool().getRankingList(_index);
    setState(() {
      if (_index == 0) {
        _dataSource = [];
      }
      if (data.length != 0) {
        _dataSource.addAll(data);
      }
    });
  }

  void moreDataSource() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        _index += 1;
        getRankingList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: _dataSource.length,
      itemExtent: 60.0,
      itemBuilder: (context, index) {
        Girl girl = _dataSource[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(girl.avatar),
          ),
          title: Text(girl.name),
          trailing: Column(
            children: <Widget>[
              Text("${girl.likeCount}赞"),
              Text("${girl.albumsCount}相册")
            ],
          ),
          onTap: () {
            ListModel model = ListModel("", "", girl, girl.id, "", []);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DetailsView(model)));
          },
        );
      },
    );
  }
}
