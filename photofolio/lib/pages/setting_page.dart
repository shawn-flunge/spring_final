

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:photofolio/provider/temp_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget{

  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage>{

  var str = '프로필 사진 수정';
  

  @override
  Widget build(BuildContext context) {
    Temp temp = Provider.of<Temp>(context);
    return Container(

      child: Column(

        children: [
          FlatButton(
            child: Text(str),
            onPressed: () async{
              final _image = await FlutterWebImagePicker.getImage;
              
              setState(() {
                str = _image.semanticLabel;
                temp.profile();
              });
            },
          ),
          FlatButton(
            child: Text('소개글 수정'),
            onPressed: () {
              showIntroDialog(context, temp);
            },
          )
        ],
      ),
    );
    
  }

  showIntroDialog(BuildContext context,Temp temp){
    showDialog<void>(
      context: context,
      builder: (context){
        return AlertDialog(
          actions: [
            RaisedButton(
              child: Text('확인'),
              onPressed: (){
                temp.intro();
                Navigator.of(context).pop();
              },
            ),
          ],
          content: TextField(
            maxLines: 3,

          ),
        );
      }
    );
  }


}