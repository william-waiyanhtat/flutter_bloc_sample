import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/model/account_model.dart';
import 'package:flutter_demos/model/video_list_model.dart';
import 'package:flutter_demos/utils/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //
  AccountModel _accountModel;
  Snippet _snippet;
  bool _loaded;
  String _playListId;
  VideosList videosList;

  @override
  void initState() {
    super.initState();
    _loaded = false;
    _getAccountInfo();
  }

  _getAccountInfo() async {
    _accountModel = await Services.getAccountInfo();
    Item item = _accountModel.items[0];
    _snippet = item.snippet;
    _playListId = item.contentDetails.relatedPlaylists.uploads;
    print('_playListId: $_playListId');
    videosList =
        await Services.getVideosList(playlistId: _playListId, pageToken: '');
    print(videosList.items.length);
    setState(() {
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_loaded ? _snippet.title : 'Loading...'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: null == videosList ? 0 : videosList.items.length,
                itemBuilder: (context, index) {
                  VideoItem videoItem = videosList.items[index];
                  return Row(
                    children: [
                      CachedNetworkImage(
                          imageUrl: videoItem
                              .snippet.thumbnails.thumbnailsDefault.url)
                    ],
                  );
                },
              ),
            ),
            FlatButton(
                onPressed: () async {
                  String nextToken = videosList.nextPageToken;
                  videosList = await Services.getVideosList(
                      playlistId: _playListId, pageToken: nextToken);
                  setState(() {});
                },
                child: Text('More'))
          ],
        ));
  }
}
