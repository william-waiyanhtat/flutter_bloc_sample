import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    updateTitle(widget.title);
    load();
  }

  load() async {
    updateTitle('Loading Feed...');
    //
    loadFeed().then((res) {
      //
      if (null == res || res.toString().isEmpty) {
        updateTitle('Error');
        return;
      }

      setState(() {
        _feed = res;
        _loading = _feed.title;
      });
    });
  }

  Future<RssFeed> loadFeed() async {
    try {
      final client = new http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {
      print('error');
      updateTitle('Error Loading Feed');
    }
    return null;
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

  updateTitle(message) {
    setState(() {
      _loading = message;
    });
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
                return ListTile(
                  title: title(item.title),
                  leading: thumbnail(item.enclosure.url),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Colors.grey, size: 30.0),
                  subtitle: Text('Published at ' + item.pubDate),
                  contentPadding: EdgeInsets.all(16.0),
                  onTap: () {
                    _launchInApp(item.link);
                  },
                );
              },
            ),
    );
  }
}
