import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class ServiceDetail extends StatefulWidget {
  const ServiceDetail({Key key}) : super(key: key);

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  @override
  final assets = 'assets/img/sample_video.mp4';
   VideoPlayerController controller;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset('assets/img/sample_video.mp4')
    ..addListener(()=>setState(() {}))
        ..setLooping(true)
        ..initialize().then((_)=>controller.play());
  }

  @override

  // YoutubePlayerController _controller;
  // TextEditingController _idController;
  // TextEditingController _seekToController;
  // PlayerState _playerState;
  // YoutubeMetaData _videoMetaData;
  // double _volume = 100;
  // bool _muted = false;
  // bool _isPlayerReady = false;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   _controller = YoutubePlayerController(
  //     initialVideoId:'C72WkcUZvco',
  //     flags: const YoutubePlayerFlags(
  //       mute: false,
  //       autoPlay: false,
  //       disableDragSeek: false,
  //       loop: false,
  //       isLive: false,
  //       forceHD: false,
  //       enableCaption: true,
  //     ),
  //   )..addListener(listener);
  //   _idController = TextEditingController();
  //   _seekToController = TextEditingController();
  //   _videoMetaData = const YoutubeMetaData();
  //   _playerState = PlayerState.unknown;
  // }
  // void listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _playerState = _controller.value.playerState;
  //       _videoMetaData = _controller.metadata;
  //     });
  //   }
  // }
  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   _controller.pause();
  //   super.deactivate();
  // }
  //
  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Service Details",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor:  Get.theme.colorScheme.secondary,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            // Get.back()
          },
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              width: 360,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),

              ),
              child:    VideoPlayer(controller),

              // child: YoutubePlayerBuilder(
              //
              //   onEnterFullScreen: (){
              //     SystemChrome.setPreferredOrientations(DeviceOrientation.values);
              //
              //   },
              //   builder: (context, player) => Scaffold(
              //     appBar: AppBar(
              //       leading: Padding(
              //         padding: const EdgeInsets.only(left: 12.0),
              //         child: Image.asset(
              //           'assets/ypf.png',
              //           fit: BoxFit.fitWidth,
              //         ),
              //       ),
              //       title: const Text(
              //         'Youtube Player Flutter',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //       actions: [
              //         IconButton(
              //             icon: const Icon(Icons.video_library),
              //             onPressed: () {}
              //         ),
              //       ],
              //     ),
              //   ),
              //
              //   player:YoutubePlayer(
              //     controller: _controller,
              //     showVideoProgressIndicator: true,
              //
              //
              //     progressIndicatorColor: Colors.blueAccent,
              //     topActions: <Widget>[
              //       const SizedBox(width: 8.0),
              //       Expanded(
              //         child: Text(
              //           _controller.metadata.title,
              //           style: const TextStyle(
              //             color: Colors.white,
              //             fontSize: 18.0,
              //           ),
              //           overflow: TextOverflow.ellipsis,
              //           maxLines: 1,
              //         ),
              //       ),
              //       IconButton(
              //         icon: const Icon(
              //           Icons.settings,
              //           color: Colors.white,
              //           size: 25.0,
              //         ),
              //         onPressed: () {
              //
              //         },
              //       ),
              //     ],
              //     onReady: () {
              //       _isPlayerReady = true;
              //     },
              //     // onEnded: (data) {
              //     //   _controller
              //     //       .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
              //     //   _showSnackBar('Next Video Started!');
              //     // },
              //   ),
              // ) ,
            ),
          ],
        ),
      ),

    );
  }
}
