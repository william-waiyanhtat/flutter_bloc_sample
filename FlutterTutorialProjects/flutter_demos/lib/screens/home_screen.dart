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
  bool _loading;
  Item _item;
  String _playListId;
  VideosList _videosList;
  ScrollController _scrollController;
  String _nextPageToken;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _nextPageToken = '';
    _scrollController = ScrollController();
    _videosList = VideosList();
    _videosList.videos = List();
    _getAccountInfo();
  }

  _getAccountInfo() async {
    _accountModel = await Services.getAccountInfo();
    _item = _accountModel.items[0];

    print('Videos: ${_item.statistics.videoCount}');
    _playListId = _item.contentDetails.relatedPlaylists.uploads;
    print('_playListId: $_playListId');
    await _loadVideos();
    print(_videosList.videos.length);
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : _item.snippet.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (scrollDetails.metrics.pixels ==
                    scrollDetails.metrics.maxScrollExtent) {
                  _loadVideos();
                }
                return true;
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount:
                    null == _videosList.videos ? 0 : _videosList.videos.length,
                itemBuilder: (context, index) {
                  VideoItem videoItem = _videosList.videos[index];
                  return Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: videoItem
                              .snippet.thumbnails.thumbnailsDefault.url,
                        ),
                        SizedBox(width: 20),
                        Flexible(child: Text(videoItem.snippet.title)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _loadVideos() async {
    VideosList tempVideosList = await Services.getVideosList(
        playlistId: _playListId, pageToken: _nextPageToken);
    _nextPageToken = tempVideosList.nextPageToken;
    _videosList.videos.addAll(tempVideosList.videos);
    setState(() {});
  }
}
