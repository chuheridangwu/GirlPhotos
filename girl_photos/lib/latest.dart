import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:girl_photos/details.dart';
import 'package:girl_photos/network_tool.dart';
import 'package:girl_photos/picture_list.dart';
import 'package:transparent_image/transparent_image.dart';

class LatestView extends StatefulWidget {
  @override
  _LatestViewState createState() => _LatestViewState();
}

class _LatestViewState extends State<LatestView> {
  List _dataSource = [];
  int _index = 1;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
    // getLatestData();
    _controller.addListener(moreDataSource);
  }

   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 获取最新接口
  void getLatestData() async {
    List data = await NetWorkTool().getLatestList(_index);
    setState(() {
      if (_index == 1) {
        _dataSource = [];
      }
      _dataSource.addAll(data);
    });
  }

  // 获取更多
  void moreDataSource() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        _index += 1;
        getLatestData();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StaggeredGridView.countBuilder(
        controller: _controller,
        crossAxisCount: 4,
        crossAxisSpacing: 4.0,
        padding: EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        itemCount: _dataSource.length,
        itemBuilder: (context, index) {
          return PhotoView(_dataSource[index]);
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      ),
    );
  }
}

class PhotoView extends StatelessWidget {
  final ListModel model;
  PhotoView(this.model);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: model.photos[0].url,
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return PictureListView(model);
                }));
              },
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
