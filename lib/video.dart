import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
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
                Navigator.pop(context);
              }
          ),
        ),
        body:  Center(
          child: BetterPlayer.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            betterPlayerConfiguration: BetterPlayerConfiguration(
              aspectRatio: 1,
              fit: BoxFit.contain,
            ),
          ),
        ),

    );
  }
}
