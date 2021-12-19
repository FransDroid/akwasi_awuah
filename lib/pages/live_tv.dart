import 'package:akwasi_awuah/widgets/banner_ad.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models.dart';
import '../view_controller.dart';

class LiveTV extends StatefulWidget {
  const LiveTV({Key? key}) : super(key: key);

  @override
  _LiveTVState createState() => _LiveTVState();
}

class _LiveTVState extends State<LiveTV> {
  late ViewController model;
  List<AdsListModel> adList = <AdsListModel>[];
  bool isLoading = false;
  late YoutubePlayerController _controller;
  String? videoId;
  bool _isPlayerReady = false;
  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;

  _LiveTVState();

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() async {
    _controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  void init() async {
    isLoading = true;
    model = Provider.of<ViewController>(context, listen: false);
    final getTV = await model.getTV();
    videoId = YoutubePlayer.convertUrlToId(getTV!.tv_url.toString());
    setState(() {
      isLoading = false;
    });
  }


  Widget _body(BuildContext context) {
    if (isLoading) {
      return Center(
          child: PlatformCircularProgressIndicator()
      );
    } else {
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
            isLive: true,
        ),
      );
      return YoutubePlayerBuilder(
          onExitFullScreen: () {
            SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          },
          onEnterFullScreen: (){
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
          },
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            return Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/background.jpg'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  player,
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ReusableInlineExample(),
                    ),
                  )
                ],
              ),
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }
}