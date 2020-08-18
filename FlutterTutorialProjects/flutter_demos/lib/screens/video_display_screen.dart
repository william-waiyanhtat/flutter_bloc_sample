import 'package:flutter/material.dart';
import 'package:flutter_demos/model/video_list_model.dart';
import 'package:flutter_demos/utils/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDisplayScreen extends StatefulWidget {
  //
  VideoDisplayScreen({this.videoItem});
  final VideoItem videoItem;

  @override
  _VideoDisplayScreenState createState() => _VideoDisplayScreenState();
}

class _VideoDisplayScreenState extends State<VideoDisplayScreen> {
  //
  YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.videoItem.video.resourceId.videoId,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
        ))
      ..addListener(listener);
    Services.getAccountInfo();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      //
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.videoItem.video.title),
      ),
      body: Container(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          onReady: () {
            print('Player is ready.');
            _isPlayerReady = true;
          },
        ),
      ),
    );
  }
}
