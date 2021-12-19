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
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                PlatformText(Strings.appName,
                    style: textTheme.headline5!.copyWith(fontSize: 24,color: Colors.white),
                    textAlign: TextAlign.left),
                PlatformText(
                  "\nDeveloped by JimahTech Limited \nPhone: 0242089562/ 0244 011 213 /0244205601 \nEmail: evgakwasiawuah@gmail.com\n\n",
                  style: textTheme.bodyText2!.copyWith(fontSize: 18,color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                PlatformText("Contact Us",
                    style: textTheme.headline6!.copyWith(fontSize: 20,color: Colors.white),
                    textAlign: TextAlign.left),
                const SizedBox(height: 20,),
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
                const SizedBox(height: 10,),
                PlatformTextField(
                  autofocus: false,
                  hintText: 'Full Name',
                  material: (_, __)  => MaterialTextFieldData(
                    decoration: const InputDecoration(labelText: 'Full Name'),
                  ),
                  onChanged: (value) {
                  },
                ),
                const SizedBox(height: 10,),
                PlatformTextField(
                  controller: _controller,
                  maxLines: 3,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  hintText: 'Message',
                  material: (_, __)  => MaterialTextFieldData(
                    decoration: const InputDecoration(labelText: 'Message'),
                  ),
                  onChanged: (value) {
                  },
                ),
                const SizedBox(height: 20,),
                PlatformTextButton(
                  child: PlatformText('Ok',style: textTheme.headline5!.copyWith(color: Theme.of(context).primaryColor),),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
