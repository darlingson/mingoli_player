import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  List<FileSystemEntity> _videos = [];
  late VideoPlayerController _controller;

  Future<void> getVideos() async {
    final directory = await getExternalStorageDirectory();
    final files = await directory?.list();
    final videos = files?.where((file) => file.path.endsWith('.mp4'));

    videos?.toList().then((videoList) {
      setState(() {
        _videos = videoList;
      });
    });
  }

  void _playVideo(String filePath) {
    _controller = VideoPlayerController.file(File(filePath));
    _controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: _videos.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : _controller != null
          ? Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_videos.elementAt(index).path),
                  onTap: () {
                    _playVideo(_videos.elementAt(index).path);
                  },
                );
              },
            ),
          ),
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ],
      )
          : ListView.builder(
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_videos.elementAt(index).path),
            onTap: () {
              _playVideo(_videos.elementAt(index).path);
            },
          );
        },
      ),
    );
  }
}
