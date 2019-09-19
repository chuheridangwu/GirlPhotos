import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:girl_photos/network_tool.dart';
import 'package:girl_photos/picture_list.dart';
import 'package:transparent_image/transparent_image.dart';

// 个人信息中心
class DetailsView extends StatefulWidget {
  final ListModel model;
  DetailsView(this.model);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  DetailModel _detailModel = DetailModel([], "", "");
  int _index = 1;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    print(widget.model.girl);
    getUserInfo();
    _controller.addListener(moreListData);
  }

  void getUserInfo() async {
    DetailModel m = DetailModel([], "", "");
    m = await NetWorkTool().getUserInfo(widget.model.girlId, _index);
    setState(() {
      if (_index == 1) {
        _detailModel = m;
      } else {
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
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (context, boxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(widget.model.content),
              expandedHeight: 200.0,

              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(widget.model.girl.avatar, fit: BoxFit.fill)),
              ),
          ];
        },
        body: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          padding: EdgeInsets.all(4.0),
          itemCount: _detailModel.albums.length,
          itemBuilder: (context, index) {
            return PhotoView(_detailModel.albums[index], widget.model);
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        ),
      ),
    );
  }
}

class PhotoView extends StatelessWidget {
  final ListModel model; // 详情模型
  final ListModel topModel; //首页的模型
  PhotoView(this.model, this.topModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: "${model.photos[0].url}",
              ),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
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
            MaterialPageRoute(builder: (context) => DetailsView(topModel)));
      },
    );
  }
}
