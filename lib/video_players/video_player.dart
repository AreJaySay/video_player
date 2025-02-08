import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  List<String> _vids = ["boxing","heavy_lefting","jogging","lefting","cardio","cardio2"];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: (itemWidth / itemHeight),
          controller: new ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            for(int x = 0; x < _vids.length; x++)...{
              CurrentVideo(video: _vids[x],)
            }
          ]
        ),
      ),
    );
  }
}

class CurrentVideo extends StatefulWidget {
  final String video;
  CurrentVideo({required this.video});
  @override
  State<CurrentVideo> createState() => _CurrentVideoState();
}

class _CurrentVideoState extends State<CurrentVideo> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/videos/${widget.video}.mp4")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
      ),
      child: _controller!.value.isInitialized
          ? Stack(
            children: [
              Center(
                child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                  width: _controller!.value.size.width,
                  height: _controller!.value.size.height,
                  child: VideoPlayer(_controller!,)),
                        ),
              ),
              Center(child: Icon(Icons.play_circle_outline_rounded,color: Colors.teal,size: 30,))
            ],
          )
          : CircularProgressIndicator(color: Colors.teal,),
    );
  }
}
