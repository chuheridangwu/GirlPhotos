import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:girl_photos/network_tool.dart';

class DetailsView extends StatefulWidget {
  ListModel model;
  DetailsView(this.model);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  DetailModel _detailModel = DetailModel([],"","");
  int _index = 1;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    print(widget.model.content);
    getUserInfo();
    _controller.addListener(moreListData);
  }

  void getUserInfo() async {
    DetailModel m =  DetailModel([],"","");
    m = await NetWorkTool().getUserInfo(widget.model.girlId, _index);
    setState(() {
      if (_index == 1){
        _detailModel = m;
      }else{
        _detailModel.albums.addAll(m.albums);
      }
    });
  }

  //  加载更多
  void moreListData() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        _index += 1;
        getUserInfo();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.model.girl.name}"),
      ),
      body: StaggeredGridView.countBuilder(
        controller: _controller,
        crossAxisCount: 4,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        padding: EdgeInsets.all(8),
        itemCount: _detailModel.albums.length,
        itemBuilder: (context, index) {
          return PhotoView(_detailModel.albums[index],widget.model);
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      ),
    );
  }
}

class PhotoView extends StatelessWidget {
  ListModel model; // 详情模型
  ListModel topModel; //首页的模型
  PhotoView(this.model,this.topModel);

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
                  backgroundImage: NetworkImage(topModel.girl.avatar),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    "${topModel.girl.name}   ${topModel.content} ",
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
