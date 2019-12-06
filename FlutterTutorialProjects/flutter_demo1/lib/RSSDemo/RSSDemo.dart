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

  @override
  void initState() {
    super.initState();
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
    updateTitle('Loading Feed...');
    loadFeed().then((res) {
      if (null == res || res.toString().isEmpty) {
        updateTitle('Error Loading Feed.');
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
    } else {
      updateTitle('Error opening Feed');
    }
  }

  thumbnail(url) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: CachedNetworkImage(
        placeholder: (context, url) => Image.asset('images/no_image.png'),
        imageUrl: url,
        height: 50,
        width: 50,
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

  subtitle(title) {
    return Text(
      title,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  isFeedEmpty() {
    return null == _feed || null == _feed.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => load(),
          ),
        ],
      ),
      body: isFeedEmpty()
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _feed.items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                final item = _feed.items[index];
                return ListTile(
                  title: title(item.title),
                  leading: thumbnail(item.enclosure.url),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.grey, size: 30.0),
                  subtitle: subtitle(item.pubDate),
                  contentPadding: EdgeInsets.all(5.0),
                  onTap: () {
                    _launchInApp(context, item.link);
                  },
                );
              },
            ),
    );
  }
}
