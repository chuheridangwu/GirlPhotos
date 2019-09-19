import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'network_tool.dart';

//  图片浏览
class PictureListView extends StatefulWidget {
  final ListModel model;
  PictureListView(this.model);
  @override
  _PictureListViewState createState() => _PictureListViewState();
}

class _PictureListViewState extends State<PictureListView> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, isScroll) {
        return [
          SliverAppBar(
            title: Text('PictureListView'),
          )
        ];
      },
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.model.photos.length,
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
              Center(
                child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: widget.model.photos[index].url,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
