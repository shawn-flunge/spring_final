

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:photofolio/provider/user_provider.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget{

  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage>{

  PlatformFile profileFile;
  var str = '프로필 사진 수정';
  TextEditingController introTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    print(userProvider.getMe().imgPath.toString());
    return Container(

      child: Column(

        children: [
          FlatButton(
            child: Text(str),
            onPressed: () async{
              FilePickerResult result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg','png','jpeg' ],
              );

              if(result != null) {
                profileFile = result.files.first;
                if(profileFile.extension == 'jpg' || profileFile.extension == 'png' || profileFile.extension == 'jpeg' )
                {
                  print(profileFile.name);
                  print(profileFile.size);
                  print(profileFile.extension);

                  setState(() {
                    str = profileFile.name;
                  });
                  setProfile(0,userProvider);
                }
                else{
                  print('file is not img');
                }            
              } else {
                // User canceled the picker
                print('result is null');
              }
            },
          ),
          FlatButton(
            child: Text('소개글 수정'),
            onPressed: () {
              showIntroDialog(context, userProvider);
            },
          ),
        ],
      ),
    );
    
  }

  setProfile(int type, UserProvider userProvider) async{
    FormData formData;
    Dio dio = Dio();

    //type == 0 then image, type == 1 then info
    if(type == 0){
      List<int> imageData = profileFile.bytes;
      MultipartFile multipartFile = MultipartFile.fromBytes(
        imageData,
        filename: profileFile.name,
        contentType: MediaType('image',profileFile.extension)
      );

      formData = FormData.fromMap({
        'nickname' : userProvider.getMe().nickname,
        'multipartfile' : multipartFile,
      });
      var response = await dio.post(baseUrl+'/profile/image', data: formData,);

      if(response.statusCode ==200){
        userProvider.login(userProvider.getMe().eMail, userProvider.getMe().password);
      } 
    }else if(type ==1){
      
      formData = FormData.fromMap({
        'nickname' : userProvider.getMe().nickname,
        'info' : introTextController.text
      });
      var response = await dio.post(baseUrl+'/profile/info', data: formData,);

      if(response.statusCode ==200){
        userProvider.login(userProvider.getMe().eMail, userProvider.getMe().password);
      }
    }
    

    
  }

  showIntroDialog(BuildContext context,UserProvider userProvider){
    showDialog<void>(
      context: context,
      builder: (context){
        return AlertDialog(
          actions: [
            RaisedButton(
              child: Text('확인'),
              onPressed: (){
                setProfile(1,userProvider);
                Navigator.of(context).pop();
              },
            ),
          ],
          content: TextField(
            controller: introTextController,
            maxLines: 3,
          ),
        );
      }
    );
  }


}