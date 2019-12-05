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
      'https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.rss';
  String _loading;

  @override
  void initState() {
    super.initState();
    _loading = widget.title;
    setState(() {
      _loading = 'Loading...';
    });
    load().then((res) {
      setState(() {
        _feed = res;
        _loading = _feed.title;
      });
    });
  }

  Future<RssFeed> load() async {
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
      ),
      body: null == _feed || null == _feed.items
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _feed.items.length,
              itemBuilder: (BuildContext ctxt, int index) {
                final item = _feed.items[index];
                print('Media ${item.media.thumbnails}');
                return ListTile(
                  title: Text(item.title),
                  trailing: Image.network(
                      'http://pngimg.com/uploads/apple/apple_PNG12509.png'),
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
