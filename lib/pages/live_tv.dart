import 'dart:io';

import 'package:akwasi_awuah/widgets/banner_ad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../helper.dart';
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
  String? videoId;

  _LiveTVState();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    init();
  }

  @override
  void dispose() async {
    super.dispose();
  }

  void init() async {
    isLoading = true;
    model = Provider.of<ViewController>(context, listen: false);
    final getTV = await model.getTV();
    videoId = Helper.convertUrlToId(getTV!.tv_url.toString());
    setState(() {
      isLoading = false;
    });
  }


  Widget _body(BuildContext context) {
    if (isLoading) {
      return Center(
          child: PlatformCircularProgressIndicator()
      );
    }return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/logo_about.png'),
                      fit: BoxFit.fitHeight)),
              child: WebView(
                  initialUrl:  Uri.dataFromString(
                      "<body style=\"margin: 0; padding: 0\"><iframe  allowfullscreen=\"allowfullscreen\" width=\"100%\" height=\"100%\" src=\"https://www.youtube-nocookie.com/embed/" +
                          "$videoId" +
                          "\" frameborder=\"0\" allowfullscreen></iframe></body>",
                      mimeType: 'text/html')
                      .toString(),
                  javascriptMode: JavascriptMode.unrestricted),
            ),
            const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: ReusableInlineExample(),
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