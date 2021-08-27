import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'models/video_link.dart';
class Video extends StatefulWidget {
  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
            size: 25.0,
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.popAndPushNamed(context,'/note_file');
              }
          ),
        ),
        body:  Center(
          child: BetterPlayer.network('${vid.name}',
            betterPlayerConfiguration: BetterPlayerConfiguration(
              autoPlay: true,
              aspectRatio: 1,
              fit: BoxFit.contain,
            ),
          ),
        ),

    );
  }
}
