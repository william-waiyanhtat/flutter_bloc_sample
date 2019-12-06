import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class RSSDemo extends StatefulWidget {
  RSSDemo() : super();

  final String title = "RSS Demo";

  @override
  RSSDemoState createState() => RSSDemoState();
}

class RSSDemoState extends State<RSSDemo> {
  //
  RssFeed _feed;
  static const String FEED_URL =
      'https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss';
  String _loading;

  @override
  void initState() {
    super.initState();
    load();
  }

  load() async {
    _loading = widget.title;
    setState(() {
      _loading = 'Loading...';
    });
    loadFeed().then((res) {
      setState(() {
        _feed = res;
        _loading = _feed.title;
      });
    });
  }

  Future<RssFeed> loadFeed() async {
    final client = new http.Client();
    final response = await client.get(FEED_URL);
    final feed = new RssFeed.parse(response.body);
    return feed;
  }

  Future<void> _launchInApp(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,
      );
    } else {
      print('Error opening Feed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              load();
            },
          ),
        ],
      ),
      body: null == _feed || null == _feed.items
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _feed.items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                final item = _feed.items[index];
                print('Media ${item.enclosure.url}');
                return ListTile(
                  title: Text(item.title),
                  leading: FadeInImage.assetNetwork(
                    placeholder: 'images/no_image.png',
                    image: item.enclosure.url,
                    width: 50,
                    fit: BoxFit.fill,
                    alignment: Alignment.center,
                  ),
                  subtitle: Text('Published at ' + item.pubDate),
                  contentPadding: EdgeInsets.all(16.0),
                  onTap: () async {
                    _launchInApp(item.link);
                  },
                );
              },
            ),
    );
  }
}
