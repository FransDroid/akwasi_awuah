import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../config.dart';
import '../theme.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            PlatformText(Strings.appName,
                style: textTheme.headline5!.copyWith(fontSize: 24),
                textAlign: TextAlign.left),
            PlatformText(
              "\nDeveloped by JimahTech Limited \nPhone: 0242089562/ 0244 011 213 /0244205601 \nEmail: evgakwasiawuah@gmail.com\n\n",
              style: textTheme.bodyText2!.copyWith(fontSize: 18),
              textAlign: TextAlign.left,
            ),
            PlatformText("Contact Us",
                style: textTheme.headline6!.copyWith(fontSize: 20),
                textAlign: TextAlign.left),
            PlatformTextField(
              autofocus: false,
              material: (_, __)  => MaterialTextFieldData(
                decoration: const InputDecoration(
                    labelText: 'E-Mail',
                    hintText: 'eg. business@jimahtech.com'),
              ),
              hintText: 'eg. business@jimahtech.com',
              onChanged: (value) {

              },
            ),
            PlatformTextField(
              autofocus: false,
              hintText: 'Full Name',
              material: (_, __)  => MaterialTextFieldData(
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              onChanged: (value) {
              },
            ),
            PlatformTextField(
              controller: _controller,
              maxLines: 3,
              autofocus: false,
              hintText: 'Message',
              material: (_, __)  => MaterialTextFieldData(
                decoration: const InputDecoration(labelText: 'Message'),
              ),
              onChanged: (value) {
              },
            ),
            const SizedBox(height: 20,),
            PlatformTextButton(
              child: PlatformText('Ok'),
              onPressed: () {
              },
            ),
          ],
        ),
      ),
    );
  }
}
