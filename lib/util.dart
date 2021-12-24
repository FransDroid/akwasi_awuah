import 'package:akwasi_awuah/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'config.dart';

enum ModalDialogTypes { info, success, error, warning }

Widget createErrorWidget(BuildContext context, {String error = ""}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
         Icon(
          context.platformIcons.error,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child:
              error.isNotEmpty ? null : PlatformText('Error: $error'),
        )
      ],
    ),
  );
}

Widget createProgressWidget(BuildContext context,
    {String message = "Please wait..."}) {
  return Center(
      child: Container(
          height: 90.0,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(45.0)),
          ),
          child: Column(
            children: <Widget>[
              PlatformCircularProgressIndicator(),
              const SizedBox(
                height: 8.0,
              ),
              PlatformText(
                message,
                style: textTheme.headline6!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          )));
}

logWithTime(String message) {
  logWithTime("${DateTime.now()}: $message");
}

showProgressModal(BuildContext context, {required String message}) {
  showPlatformDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PlatformAlertDialog(
          content: SizedBox(
              height: 100,
              child: createProgressWidget(context, message: message)));
    },
  );
}

showMessageModal(BuildContext context,
    {required String title,
    required String message,
     ModalDialogTypes type = ModalDialogTypes.info}) {
  Icon modalIcon;

  switch (type) {
    case ModalDialogTypes.info:
      modalIcon = Icon(context.platformIcons.info,
          color: Colors.lightBlue.shade700, size: 28.0);
      break;
    case ModalDialogTypes.success:
      modalIcon = Icon(context.platformIcons.checkMarkCircled,
          color: Colors.green.shade700, size: 28.0);
      break;
    case ModalDialogTypes.error:
      modalIcon = Icon(context.platformIcons.error,
          color: Colors.red.shade700, size: 28.0);
      break;
    case ModalDialogTypes.warning:
      modalIcon =
          Icon(Icons.warning, color: Colors.amber.shade700, size: 28.0);
      break;
    default:
      modalIcon = Icon(context.platformIcons.info,
          color: Colors.lightBlue.shade700, size: 28.0);
      break;
  }

  return  showPlatformDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return PlatformAlertDialog(
        title: Row(
          children: <Widget>[
            modalIcon,
            const SizedBox(
              width: 12.0,
            ),
            PlatformText(
              title,
              style: textTheme.headline5!.copyWith(fontSize: 20),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            type == ModalDialogTypes.success?  Icon(context.platformIcons.checkMarkCircled, color: Colors.green, size: 100.0,): Container(),
            PlatformText(
              message,
              style: textTheme.subtitle2!.copyWith(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: PlatformText(
              'OK',
              style: textTheme.headline5!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          )
        ],
      );
    },
  );
}

showAlertModalCustomRoute(BuildContext context, {required String message,required String route}){
  return PlatformAlertDialog(
    content: Container(
        padding:const EdgeInsets.all(10),
        child: PlatformText(message,style: textTheme.headline5!.copyWith(fontSize: 18),)
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pushNamedAndRemoveUntil(context,route, (r)=> false),
        child: PlatformText('Login',style: textTheme.headline5!.copyWith(color: Theme.of(context).primaryColor),),
      )
    ],
  );
}

String formatDateTime(DateTime dateTime){
  final period = TimeOfDay.fromDateTime(dateTime);
  return "${period.hourOfPeriod==0? 12: period.hourOfPeriod }: ${period.minute} ${period.period==DayPeriod.am? 'am': 'pm'}";
}

 myBoxDecoration(){
  return const BoxDecoration(
  shape: BoxShape.rectangle,
  color: Colors.white,
  borderRadius: BorderRadius.only(
  topLeft: Radius.circular(10.0),
  topRight: Radius.zero,
  bottomLeft: Radius.zero,
  bottomRight: Radius.circular(10.0),
  ));
}


 myMaterialTextFormFieldData(String label,String hintText){
  return MaterialTextFormFieldData(
    decoration:  InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
        hintText: hintText,
        labelText: label),
    style: const TextStyle(color: Colors.white),
  );
 }

 myCupertinoTextFormFieldData(){
  return CupertinoTextFormFieldData(
      decoration: const BoxDecoration(
          color: CupertinoColors.lightBackgroundGray
      )
  );
 }