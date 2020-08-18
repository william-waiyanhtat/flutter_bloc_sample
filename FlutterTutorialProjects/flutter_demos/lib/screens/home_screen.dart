import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demos/model/account_model.dart';
import 'package:flutter_demos/model/video_list_model.dart';
import 'package:flutter_demos/screens/video_display_screen.dart';
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
        title: Text('Youtube'),
      ),
      body: Column(
        children: [
          _buildProfile(),
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
                  return InkWell(
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return VideoDisplayScreen(
                          videoItem: videoItem,
                        );
                      }));
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: videoItem
                                .video.thumbnails.thumbnailsDefault.url,
                          ),
                          SizedBox(width: 20),
                          Flexible(child: Text(videoItem.video.title)),
                        ],
                      ),
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

  _buildProfile() {
    return _loading
        ? Container()
        : Container(
            padding: EdgeInsets.all(10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: _item.snippet.thumbnails.medium.url,
                      height: 60,
                      width: 60,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                        child: Text(
                      _item.snippet.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    )),
                    Text(_item.statistics.videoCount),
                    SizedBox(width: 20),
                  ],
                ),
              ),
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
