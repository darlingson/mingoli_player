import 'dart:io';

import 'package:flutter/material.dart';
import 'package:list_all_videos/list_all_videos.dart';
import 'package:list_all_videos/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  List<VideoDetails> _videos = [];
  VideoPlayerController? _controller;

  late String _message;

  late bool _isLoading;

  Future<void> getVideos() async {
    final videos = await ListAllVideos().getAllVideosPath();

    if (videos.isEmpty) {
      _message = 'No videos found';
    } else {
      _videos = videos;
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _playVideo(String filePath) {
    _controller = VideoPlayerController.file(File(filePath));
    _controller?.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _videos.isEmpty
          ? Center(
        child: Text(_message),
      )
          : _controller != null
          ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_videos.elementAt(index).videoName),
                  onTap: () {
                    _playVideo(_videos.elementAt(index).videoPath);
                  },
                );
              },
            ),
          ),
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
        ],
      )
          : ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_videos.elementAt(index).videoName),
            onTap: () {
              _playVideo(_videos.elementAt(index).videoPath);
            },
          );
        },
      ),
    );
  }
}