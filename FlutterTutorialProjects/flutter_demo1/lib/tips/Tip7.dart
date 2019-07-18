import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Tip7 extends StatefulWidget {
  Tip7() : super();

  final String title = "Flutter Tips";

  @override
  Tip7State createState() => Tip7State();
}

class Tip7State extends State<Tip7> with SingleTickerProviderStateMixin {
  //
  String fadeImgUrl =
      'https://images.freeimages.com/images/large-previews/322/indian-heads-1391201.jpg';
  String cacheImgUrl =
      'https://images.freeimages.com/images/large-previews/7e9/ladybird-1367182.jpg';

  Widget toolTipWidget() {
    return Tooltip(
      message: "This is a tooltip",
      child: new Text("Long press to see Tooltip"),
    );
  }

  Widget fadeImage() {
    return FadeInImage.assetNetwork(
      placeholder: 'images/loading.gif',
      image: fadeImgUrl,
    );
  }

  Widget cacheImage() {
    return CachedNetworkImage(
      placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: cacheImgUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: cacheImage(),
        ),
      ),
    );
  }
}
