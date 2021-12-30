
import 'dart:async';
import 'dart:io';

import 'package:akwasi_awuah/models.dart';
import 'package:akwasi_awuah/view_controller.dart';
import 'package:akwasi_awuah/widgets/banner_ad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:provider/provider.dart';

import '../config.dart';
import '../theme.dart';
bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;

class LiveRadio extends StatefulWidget {
  const LiveRadio({Key? key}) : super(key: key);

  @override
  _LiveRadioState createState() => _LiveRadioState();
}

class _LiveRadioState extends State<LiveRadio> {
  late AudioPlayer _player;
  String url = 'https://stream-mz.planetradio.co.uk/planetrock.mp3';
  bool isLoading = false;
  late ViewController model;
  String name = '';
  List<AdsListModel> adList = <AdsListModel>[];


  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

 Future<void> _init() async{
    isLoading = true;
    model = Provider.of<ViewController>(context, listen: false);
    final getRadio = await model.getRadio();
    RadioResponse data = getRadio[0];
    name = data.frequency.toString();

    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    try{
      await _player.setAudioSource(
          AudioSource.uri(
            Uri.parse(data.url.toString()),
            tag: MediaItem(
              id: data.id.toString(),
              album: data.name,
              title: data.frequency.toString(),
              artUri: Uri.parse(Strings.radioImage),
            ),
          ));
    }catch(e, stackTrace) {
    // Catch load errors: 404, invalid url ...
    print("Error loading playlist: $e");
    print(stackTrace);
    }
    setState(() {

    });
  }
   @override
   void dispose() {
     _player.dispose();
     super.dispose();
   }

  @override
  Widget build(BuildContext context) {
    return _mainBody(context);
  }

   Widget _mainBody(BuildContext context){
     return Stack(
       children: <Widget>[
         Container(
           decoration: const BoxDecoration(
               image: DecorationImage(
                   image: AssetImage('images/background.jpg'),
                   fit: BoxFit.cover)),
         ),
         _buildBody()
       ],
     );
   }

   Widget _buildBody() {
     model = Provider.of<ViewController>(context);
     return  Stack(
       children: <Widget>[
         Column(
           children: <Widget>[
              Expanded(
               child:  Column(
                 children: <Widget>[
                    Card(
                     color: isIOS? CupertinoColors.extraLightBackgroundGray :const Color(0x910076ce),
                     elevation: 2,
                     margin: const EdgeInsets.all(10),
                     child: Column(
                       children: <Widget>[
                          Container(
                           margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                           child: Image.asset('images/donate.jpg'),
                         ),
                         Container(
                           padding: const EdgeInsets.all(10),
                           child: Text(name,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                   fontSize: 14,
                                   fontWeight: FontWeight.w600,
                                   color: isIOS ? CupertinoColors.black :Colors.white)),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
               flex: 2,
             ),
             const Expanded(
               flex: 2,
               child: Padding(
                 padding: EdgeInsets.all(10.0),
                 child: ReusableInlineExample(),
               ),
             ),
              Expanded(
                flex: Platform.isAndroid ? 1 : 2,
               child: _buildPlayer(),
             )
           ],
         ),
         // Loading
        /* Positioned(
           child: isLoading ? progressBar() : Container(),
         ),*/
       ],
     );
   }

   Widget _buildPlayer() =>
       Padding(
         padding: const EdgeInsets.only(bottom: 10),
         child: StreamBuilder<PlayerState>(
           stream: _player.playerStateStream,
           builder: (context, snapshot) {
             final playerState = snapshot.data;
             final processingState = playerState?.processingState;
             final playing = playerState?.playing;
             if (processingState == ProcessingState.loading ||
                 processingState == ProcessingState.buffering) {
               return Center(child: PlatformCircularProgressIndicator());
             } else if (playing != true) {
               return PlatformIconButton(
                 icon: Icon(context.platformIcons.playArrow,color: Colors.white,size: 64,),
                 onPressed: _player.play,
               );
             } else if (processingState != ProcessingState.completed) {
               return PlatformIconButton(
                 icon:  Icon(context.platformIcons.pause,color: Colors.white,size: 64,),
                 onPressed: _player.pause,
               );
             } else {
               return PlatformIconButton(
                 icon: Icon(context.platformIcons.loop,color: Colors.white,size: 64,),
                 onPressed: () => _player.seek(Duration.zero,
                     index: _player.effectiveIndices!.first),
               );
             }
           },
         ),
       );
}
