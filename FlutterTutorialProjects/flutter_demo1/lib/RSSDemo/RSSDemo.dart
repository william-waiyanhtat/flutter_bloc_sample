import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RSSDemo extends StatefulWidget {
  RSSDemo() : super();

  final String title = "RSS Feed Demo";

  @override
  RSSDemoState createState() => RSSDemoState();
}

class RSSDemoState extends State<RSSDemo> {
  // https://github.com/witochandra/webfeed
  //
  static const String FEED_URL =
      'https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss';
  RssFeed _feed;
  String _title;
  GlobalKey<RefreshIndicatorState> refreshKey;
  static const String loadingMsg = 'Loading Feed...';
  static const String feedLoadErrorMsg = 'Error Loading Feed.';
  static const String feedOpenErrorMsg = 'Error Opening Feed.';
  static const String placeholderImg = 'images/no_image.png';

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    updateTitle(widget.title);
    load();
  }

  updateTitle(message) async {
    setState(() {
      _title = message;
    });
  }

  updateFeed(feed) async {
    setState(() {
      _feed = feed;
    });
  }

  load() async {
    updateTitle(loadingMsg);
    loadFeed().then((res) {
      if (null == res || res.toString().isEmpty) {
        updateTitle(feedLoadErrorMsg);
        return;
      }
      updateFeed(res);
      updateTitle(_feed.title);
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = new http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  Future<void> _launchInApp(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
      return;
    }
    updateTitle(feedOpenErrorMsg);
  }

  thumbnail(url) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset(placeholderImg),
        imageUrl: url,
        height: 50,
        width: 70,
        alignment: Alignment.center,
        fit: BoxFit.fill,
      ),
    );
  }

  title(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  subtitle(subTitle) {
    return Text(
      subTitle,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  rightIcon() {
    return Icon(Icons.keyboard_arrow_right, color: Colors.grey, size: 30.0);
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  list() {
    return ListView.builder(
      itemCount: _feed.items.length,
      itemBuilder: (BuildContext ctxt, int index) {
        final item = _feed.items[index];
        return ListTile(
          title: title(item.title),
          leading: thumbnail(item.enclosure.url),
          trailing: rightIcon(),
          subtitle: subtitle(item.pubDate),
          contentPadding: EdgeInsets.all(5.0),
          onTap: () => _launchInApp(context, item.link),
        );
      },
    );
  }

  body() {
    return isFeedEmpty()
        ? Center(child: CircularProgressIndicator())
        : RefreshIndicator(
            key: refreshKey,
            child: list(),
            onRefresh: () => load(),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: body());
  }
}
