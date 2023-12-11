import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyFileList(),
    );
  }
}

class MyFileList extends StatefulWidget {
  @override
  _MyFileListState createState() => _MyFileListState();
}

class _MyFileListState extends State<MyFileList> {
  var files;

  void getFiles() async {
    List<StorageInfo> storageInfo = await PathProviderEx.getStorageInfo();
    var root = storageInfo[0].rootDir; // Internal storage root directory
    var fm = FileManager(root: Directory(root));
    files = await fm.filesTree(
      excludedPaths: ["/storage/emulated/0/Android"],
      extensions: ["mp4"],
    );

    setState(() {});
  }

  @override
  void initState() {
    getFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Files in Internal Storage"),
      ),
      body: files == null
          ? Text("Searching Files")
          : ListView.builder(
        itemCount: files?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(files[index].path.split('/').last),
              leading: Icon(Icons.video_library),
            ),
          );
        },
      ),
    );
  }
}