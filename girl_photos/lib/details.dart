import 'package:flutter/material.dart';
import 'package:girl_photos/network_tool.dart';

class DetailsView extends StatefulWidget {
  ListModel model;
  DetailsView(this.model);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  void initState() {
    super.initState();
    print(widget.model.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.model.girl.name}"),
      ),
      body: Container(),
    );
  }
}
