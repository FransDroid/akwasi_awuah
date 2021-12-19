
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../config.dart';
import '../theme.dart';

class VideoPlayPauseAds extends StatefulWidget {
  VideoPlayPauseAds(this.dataSource);

  final String dataSource;
  @override
  State createState() {
    return _VideoPlayPauseState();
  }
}

class _VideoPlayPauseState extends State<VideoPlayPauseAds> {
  late VideoPlayerController _controller;
  bool isBuffering = false;
  bool isPlaying = false;
  bool isVolume = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.dataSource);
    _controller.addListener(() {
      setState(() {
        if(_controller.value.isBuffering){
          isBuffering = true;
        }else{
          isBuffering =  false;
        }
        if(_controller.value.isPlaying) {
          isPlaying = true;
        } else {
          isPlaying = false;
        }
      });
    });
    _controller.setVolume(0.0);
    _controller.initialize();
    //_controller.play();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return _controller.value.isInitialized ? Center(
        child: GestureDetector(
          onTap: (){
            _controller.value.isPlaying ? _controller.pause() : _controller.play();
          },
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ],
              ),
              Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    color: Colors.black45,
                    padding: const EdgeInsets.all(5),
                    child: Text(Strings.Lbl_Advert,style: textTheme.headline5!.copyWith(fontSize: 12,color: Colors.white),),
                  )
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.black45,
                  radius: 20,
                  child: Center(
                    child: IconButton(
                      icon: isVolume ? const Icon(Icons.volume_up, color: Colors.white,) :
                      const Icon(Icons.volume_off,color: Colors.white,),
                      onPressed: (){
                        setState(() {
                          isVolume = !isVolume;
                          isVolume ? _controller.setVolume(1.0): _controller.setVolume(0.0);
                        });
                      },
                    ),
                  ),
                ),
              ),
              /* Positioned(
                child: Center(
                    child: isBuffering
                        ?  CircularProgressIndicator()
                        : null),
              ),*/
            ],
          ),
        )
    )
        : const Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red)
      ),
    );
  }
}
