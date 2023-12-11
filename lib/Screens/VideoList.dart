import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VideoListScreen extends StatefulWidget {
  @override
  _VideoListScreenState createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  List<FileSystemEntity> _videoFiles = [];

  @override
  void initState() {
    super.initState();
    _loadVideoFiles();
  }

  Future<void> _loadVideoFiles() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      // Assuming video files have a specific extension like mp4, you can adjust this accordingly
      List<FileSystemEntity> videoFiles = Directory(appDocPath).listSync(
        recursive: true,
        followLinks: false,
      ).where((entity) => entity.path.endsWith('.mp4')).toList();

      setState(() {
        _videoFiles = videoFiles;
      });
    } catch (e) {
      print("Error loading video files: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Files'),
      ),
      body: ListView.builder(
        itemCount: _videoFiles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_videoFiles[index].uri.pathSegments.last),
            // You can add more details or functionality here
          );
        },
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: VideoListScreen(),
//   ));
// }
