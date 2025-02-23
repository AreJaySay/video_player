import 'package:flutter/material.dart';
import 'package:fitness_video_player/video_players/view_video.dart';
import 'package:video_player/video_player.dart';
import '../landing_page.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  List<String> _vids = ["html1", "html2", "css1", "css2", "js1", "js2"];
  List<String> _tutorials = ["Tutorial for HTML", "Tutorial for CSS", "Tutorial for JavaScript"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Video Playlist",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.grey.shade300,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
            );
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(_tutorials.length, (index) {
              int startIndex = index * 2;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      _tutorials[index],
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.teal.shade700),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (startIndex < _vids.length) CurrentVideo(video: _vids[startIndex]),
                      if (startIndex + 1 < _vids.length) SizedBox(width: 15),
                      if (startIndex + 1 < _vids.length) CurrentVideo(video: _vids[startIndex + 1]),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              );
            }),
          ),
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
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller != null && _controller!.value.isInitialized) {
          _controller!.pause(); // Pause before navigating
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ViewVideo(controller: _controller!)),
          );
        }
      },
      child: Container(
        width: 160,
        height: 110,
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: _controller != null && _controller!.value.isInitialized
            ? Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
            ),
            Icon(
              Icons.play_circle_fill,
              color: Colors.white,
              size: 50,
            ),
          ],
        )
            : Center(child: CircularProgressIndicator(color: Colors.teal)),
      ),
    );
  }
}
