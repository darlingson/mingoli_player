import 'package:flutter/material.dart';
import 'package:mingoli_player/homepage.dart';
import 'package:video_player/video_player.dart';

main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(title: 'Mingoli Video Player'),
      debugShowCheckedModeBanner: false,
    );
  }
}

