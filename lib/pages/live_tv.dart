import 'dart:async';
import 'dart:io';

import 'package:akwasi_awuah/widgets/ads_video_controller.dart';
import 'package:akwasi_awuah/widgets/banner_ad.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../config.dart';
import '../helper.dart';
import '../models.dart';
import '../theme.dart';
import '../view_controller.dart';

class LiveTV extends StatefulWidget {
  const LiveTV({Key? key}) : super(key: key);

  @override
  _LiveTVState createState() => _LiveTVState();
}

class _LiveTVState extends State<LiveTV> {
  final FijkPlayer player = FijkPlayer();
  late ViewController model;
  List<AdsListModel> adList = <AdsListModel>[];
  bool isLoading = false;
  String? videoId;
  late YoutubePlayerController _controller;

  _LiveTVState();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    //init();
  }

  @override
  void dispose() {
    super.dispose();
    player.release();
  }

  void init() async {
    isLoading = true;

    final getTV = await model.getTV();
    videoId = Helper.convertUrlToId(getTV!.tv_url.toString());
    setState(() {
      isLoading = false;
    });
  }

  Widget _addWidget(){
    if(adList.isNotEmpty){
      var randomItem = (adList..shuffle()).first;
      return GestureDetector(
        onTap: (){
          Helper.launchURL(randomItem.website);
        },
        child: Container(
          color: const Color(0x0ffffff0),
          child:
          randomItem.video == '[]' ?
          Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: randomItem.image.toString(),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                placeholder: (context, url) => Container(
                  //child: CircularProgressIndicator(strokeWidth: 1,),padding: EdgeInsets.all(10)
                ),
              ),
              Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    color: Colors.black45,
                    padding: const EdgeInsets.all(5),
                    child: Text(Strings.Lbl_Advert,style: textTheme.subtitle2!.copyWith(
                        color: Colors.white
                    ),),
                  )
              ),
            ],
          ) :
          Stack(
              alignment: FractionalOffset.bottomRight +
                  const FractionalOffset(-0.1, -0.1),
              children: <Widget>[
                VideoPlayPauseAds(randomItem.video!),
              ]
          ),
        ),
      );
    }else {
      return Container();
    }
  }

  Future<void> _refresh() async {
    setState(() {});
  }

  Widget _body(BuildContext context) {
    model = Provider.of<ViewController>(context, listen: false);
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          FutureBuilder(
            future: model.getTV(),
            builder: (BuildContext context,
                AsyncSnapshot<TVResponse?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return PlatformCircularProgressIndicator();
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  break;
              }
              if (snapshot.hasData) {
                if(snapshot.data!.status == '1') {
                  if (snapshot.data!.tv_status == 'youtube') {
                    videoId = Helper.convertUrlToId(
                        snapshot.data!.tv_url.toString());
                  } else {
                    player.setDataSource(
                        snapshot.data!.tv_url.toString(), autoPlay: false,
                        showCover: true);
                  }
                  return Container(
                    height: 250,
                    color: Colors.black,
                    child: snapshot.data!.tv_status == 'rtmp' ?
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: FijkView(
                          player: player,
                          fit: FijkFit.fill,
                          fsFit: FijkFit.ar16_9,
                          color: Colors.black87,
                        ),
                      ),
                    )
                        : WebView(
                        initialUrl: Uri.dataFromString(
                            "<body style=\"margin: 0; padding: 0\"><iframe  allowfullscreen=\"allowfullscreen\" width=\"100%\" height=\"100%\" src=\"https://www.youtube-nocookie.com/embed/" +
                                "$videoId" +
                                "\" frameborder=\"0\" allowfullscreen></iframe></body>",
                            mimeType: 'text/html')
                            .toString(),
                        javascriptMode: JavascriptMode.unrestricted),
                  );
                }else{
                  return Container(
                    height: 250,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/logo_about.png'),
                            fit: BoxFit.fill)),
                  );
                }
              } else {
                return Container();
              }
            }
          ),
          Expanded(
            flex: 2,
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setStateAd) {
                Timer.periodic(const Duration(seconds: 6), (_) {
                  setStateAd(() {});
                });
                return FutureBuilder(
                    future: model.getAdList(Strings.jimah_ads_news_details),
                    builder: (context, AsyncSnapshot<List<AdsListModel>> snapshot) {
                      if(snapshot.hasData) {
                        adList = snapshot.data!;
                        return _addWidget();
                      }else{
                        return Container();
                      }
                    }
                );
              },
            ),
          ),
        ],
      ),
    );
    }

  @override
  Widget build(BuildContext context) {
    return _body(context);
  }
}