import 'package:akwasi_awuah/helper.dart';
import 'package:akwasi_awuah/util.dart';
import 'package:akwasi_awuah/view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';
import '../theme.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerMessage = TextEditingController();
  final GlobalKey<FormState> _formLoginStateKey = GlobalKey<FormState>();
  late ViewController model;


  clearText(){
    _controllerMessage.clear();
    _controllerName.clear();
    _controllerEmail.clear();
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ViewController>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'),
              fit: BoxFit.cover)),
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formLoginStateKey,
                  child: Column(
                    children: <Widget>[
                      PlatformText(Strings.appName,
                          style: textTheme.headline5!.copyWith(fontSize: 24,color: Colors.white),
                          textAlign: TextAlign.left),
                      PlatformText(
                        "\nPhone: 0242089562/ 0244 011 213 /0244205601 \nEmail: evgakwasiawuah@gmail.com\n\n",
                        style: textTheme.bodyText2!.copyWith(fontSize: 18,color: Colors.white),
                        textAlign: TextAlign.left,
                      ),
                      PlatformText("Contact Us",
                          style: textTheme.headline6!.copyWith(fontSize: 20,color: Colors.white),
                          textAlign: TextAlign.left),
                      const SizedBox(height: 20,),
                      PlatformTextFormField(
                        controller: _controllerEmail,
                        autofocus: false,
                        validator: (value){
                          Pattern pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regex = RegExp(pattern.toString());
                          if (value!.isEmpty || !regex.hasMatch(value)) {
                            return 'Invalid Email Address';
                          } else {
                            return null;
                          }
                        },
                        cupertino: (_,__) => myCupertinoTextFormFieldData(),
                        material: (_, __)  => myMaterialTextFormFieldData('E-Mail','eg. evgakwasiawuah@gmail.com'),
                        hintText: 'eg. evgakwasiawuah@gmail.com',
                        onChanged: (value) {

                        },
                      ),
                      const SizedBox(height: 10,),
                      PlatformTextFormField(
                        controller: _controllerName,
                        autofocus: false,
                        hintText: 'Full Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        cupertino: (_,__) => myCupertinoTextFormFieldData(),
                        material: (_, __)  => myMaterialTextFormFieldData('Full Name','Akwasi Awuah'),
                        onChanged: (value) {
                        },
                      ),
                      const SizedBox(height: 10,),
                      PlatformTextFormField(
                        controller: _controllerMessage,
                        maxLines: 3,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                          return 'Please enter a message';
                          }
                          return null;
                          },
                        hintText: 'Message',cupertino: (_,__) => myCupertinoTextFormFieldData(),
                        material: (_, __)  => myMaterialTextFormFieldData('Message','Enter your message'),
                        onChanged: (value) {
                        },
                      ),
                      const SizedBox(height: 20,),
                      PlatformTextButton(
                        child: PlatformText('Ok',style: textTheme.headline5!.copyWith(color: Theme.of(context).primaryColor),),
                        onPressed: () async{
                          FocusScope.of(context).requestFocus(FocusNode());
                                if (_formLoginStateKey.currentState!.validate()) {
                                _formLoginStateKey.currentState!.save();
                                showProgressModal(context, message: 'Please wait!!!');
                                final sendMail = await model.sendMail(_controllerEmail.text,_controllerName.text,_controllerMessage.text);
                                if(sendMail != null && sendMail.code == '200'){
                                  Navigator.pop(context);
                                  clearText();
                                  showMessageModal(context, title: 'Success', message: 'Message Sent', type: ModalDialogTypes.success);
                                }else{
                                  Navigator.pop(context);
                                  showMessageModal(context, title: 'Error', message: 'Error occurred send message', type: ModalDialogTypes.error);
                                }
                                }
                        },
                      ),
                      const SizedBox(height: 20,),
                      Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: PlatformText('Developed by JimahTech Limited',
                            style: textTheme.subtitle2!.copyWith(color: Colors.grey),
                        textAlign: TextAlign.end,),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
