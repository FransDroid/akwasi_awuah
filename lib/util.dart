import 'package:akwasi_awuah/theme.dart';
import 'package:flutter/material.dart';

import 'config.dart';

enum ModalDialogTypes { info, success, error, warning }

Widget createErrorWidget({String error = ""}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child:
              error.isNotEmpty ? null : Text('Error: $error'),
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
              CircularProgressIndicator( valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primaryVariant),),
              const SizedBox(
                height: 8.0,
              ),
              Text(
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
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
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
      modalIcon = Icon(Icons.info_outline,
          color: Colors.lightBlue.shade700, size: 28.0);
      break;
    case ModalDialogTypes.success:
      modalIcon = Icon(Icons.check_circle_outline,
          color: Colors.green.shade700, size: 28.0);
      break;
    case ModalDialogTypes.error:
      modalIcon = Icon(Icons.error_outline,
          color: Colors.red.shade700, size: 28.0);
      break;
    case ModalDialogTypes.warning:
      modalIcon =
          Icon(Icons.warning, color: Colors.amber.shade700, size: 28.0);
      break;
    default:
      modalIcon = Icon(Icons.info_outline,
          color: Colors.lightBlue.shade700, size: 28.0);
      break;
  }

  return  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: <Widget>[
            modalIcon,
            const SizedBox(
              width: 12.0,
            ),
            Text(
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
            type == ModalDialogTypes.success? const Icon(Icons.check_circle, color: Colors.green, size: 100.0,): Container(),
            Text(
              message,
              style: textTheme.subtitle2!.copyWith(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: textTheme.headline1!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          )
        ],
      );
    },
  );
}

showAlertModalCustomRoute(BuildContext context, {required String message,required String route}){
  return AlertDialog(
    content: Container(
        padding:const EdgeInsets.all(10),
        child: Text(message,style: textTheme.headline5!.copyWith(fontSize: 18),)
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pushNamedAndRemoveUntil(context,route, (r)=> false),
        child: Text('Login',style: textTheme.headline5!.copyWith(color: Theme.of(context).primaryColor),),
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