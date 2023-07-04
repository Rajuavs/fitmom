import 'package:fitmom/Screen/Test%20video/video_items.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class TestVideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Flutter Video Player Demo'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          // VideoItems(
          //   videoPlayerController: VideoPlayerController.network(
          //     'https://www.youtube.com/watch?v=uz4xRnE-UIw',
          //   ),
          //   looping: true,
          //   autoplay: true,
          // ),
          VideoItems(
            videoPlayerController: VideoPlayerController.network(
                'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4'
            ),
            looping: false,
            autoplay: true,
          ),
          
         
          // VideoItems(
          //   videoPlayerController: VideoPlayerController.network(
          //       "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4"
          //   ),
          //   looping: true,
          //   autoplay: false,
          // ),
        ],
      ),
    );
  }
}