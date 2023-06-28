import 'dart:async';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class PlayButton extends StatefulWidget {

final String videoView;
  const PlayButton({Key key, this.videoView}) : super(key: key);

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  StreamSubscription<void> _playerSub;
 // AudioPlayer _audio;
  VideoPlayerController _videoPlayerController;

  bool _isPlaying = false;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoView);
    print("+++++++++++++++++++++++++++++++++++++++VIDEO PLAYER+++++++++++++++++++++++++++++++");

    print("++++++++++++++++++++++++++++++++++++++++++++++++");
    _videoPlayerController.addListener(() {
      setState(() {

      });
    });
    _videoPlayerController.setLooping(false);
    _videoPlayerController.initialize().then((_) => setState(() {}));
    _videoPlayerController.pause();

    //_audio = AudioPlayer(playerId: widget.id);
    //_playerSub = _audio.onPlayerCompletion.listen((event) {
     // _clearPlayer();
   // });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _clearPlayer() {
    setState(() {
      _isPlaying = false;
      _isPaused = false;
    });
  }

  Future play() async {
   // int result = await _audio.play(widget.url);
    setState(() {
    });
  }

  Future pause() async {
    setState(() {
    });
  }

  Future resume() async {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()
          {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Videos",style: TextStyle(color: Colors.blueAccent,fontSize: 18),),
        centerTitle: true,
      ),
      body: Container(
        height: 500,
        width: 400,
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _videoPlayerController.value.isInitialized
                ? FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                height: 200,
                width: 300,
                child: AspectRatio(
                  aspectRatio: 20 / 10,
                  // aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ),
            ): Container(),
         IconButton(
              onPressed: ()
              {
                setState(() {
                  // pause
                  if (_videoPlayerController.value.isPlaying) {
                    _videoPlayerController.pause();
                  }
                  else {
                    // play
                    _videoPlayerController.play();
                  }
                });
              },

              icon: (_videoPlayerController.value.isPlaying)
                  ? Icon(Icons.pause_circle_filled)
                  : Icon(Icons.play_circle_outline),
              iconSize: 40,
             // onPressed: () => _isPlaying ? pause() : _isPaused ? resume() : play(),
            ),
          ],
        ),
      ),

    );
  }
}