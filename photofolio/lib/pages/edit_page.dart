// import 'package:file_picker_web/file_picker_web.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:photofolio/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';

class EditPage extends StatefulWidget{
  @override
  EditPageState createState() => EditPageState();
}



class EditPageState extends State<EditPage>{
  
  Image currentImage;
  Image thumbnailImage;
  
  List<Image> images = List<Image>();
  Map<String, Image> imagesMap = Map<String, Image>(); //이미지라밸이 key

  List<PlatformFile> files = List<PlatformFile>();
  PlatformFile thumbnailFile;

  // List<String> comments = List<String>();
  List<String> comments = List<String>();
  Map<String,String> commentsMap = Map<String,String>(); //이미지라밸이 key
  

  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController(); 
  TextEditingController explainController = TextEditingController();
  TextEditingController linkController = TextEditingController(); 

  List<String> tags = List<String>();

  int i =0;
  String thumbnail = "섬네일 설정";

  @override
  Widget build(BuildContext context) {
    UserLogin userLogin = Provider.of<UserLogin>(context);

    return SingleChildScrollView(

      child:Column(

        children: [
          //buildImageRow(),
          Align(
            child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.cancel_outlined,),
                onPressed: () => Navigator.of(context).pop(),
            ), 
            alignment: FractionalOffset(1, 0),
          ),
          // Container(
          //   //color: Colors.deepPurple,
          //   margin: EdgeInsets.all(20),
          //   width: double.infinity,
          //   child: buildTitle(),
          // ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child:TextField( 
              controller: titleController,
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "제목",
              ),
            ),
          ),
          Container(
            // color: Colors.indigo,
            width: double.infinity,
            height: 500,
            child: buildImageRow(),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: buildComment(),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
            child: buildSubmitBtn(userLogin),
          )
          // Flexible(
          //   flex: 1,
          //   child: TextFieldTags(
          //     textFieldStyler: TextFieldStyler(
          //       hintText: "Vz",
          //       helperText: "엔터누르삼",
          //       cursorColor: Colors.orangeAccent,
          //       // textFieldFocusedBorder: ,
          //       textFieldBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.zero,
          //         borderSide: BorderSide(color: Colors.purple)
          //       ),
          //       textFieldFocusedBorder: OutlineInputBorder(
          //         gapPadding: 10,
          //         borderSide: BorderSide(color: Colors.purple)
          //       ),
          //       textFieldFilledColor: Colors.red,
          //       textFieldFilled: true
          //     ),
          //     tagsStyler: TagsStyler(
          //       tagTextStyle: TextStyle(
          //         fontWeight: FontWeight.bold,
          //       ),
          //       tagDecoration: BoxDecoration(
          //         color: Colors.deepPurpleAccent[700],
          //         borderRadius: BorderRadius.circular(7)
          //       ),
          //       tagCancelIcon: Icon(
          //         Icons.cancel,
          //         color: Colors.white,
          //       )
          //     ),
          //     onTag: (tag) {
          //       //This give you tags entered
          //       print('onTag ' + tag);
          //       tags.add(tag);
          //       print(tags.toString());
          //     },
          //     onDelete: (tag) {
          //       print('onDelete ' + tag);
          //       tags.remove(tag);
          //       print(tags.toString());
          //     },

          //   )
          // ),
          // Flexible(
          //   child: RaisedButton(
          //     child: Text('finish'),
          //     onPressed: (){
          //       Navigator.of(context).pop();
          //     },
          //   )
          // )

        ],
      )
    );
    
    
  }

  Widget buildImageRow(){
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [        
        Container(
          width: 400,
          //color: Colors.deepPurple,
          //padding: EdgeInsets.all(100),
          //margin: EdgeInsets.fromLTRB(10, 20, 20, 10),
          child: Swiper(
            //containerWidth: 200,
            itemWidth: 500,
            itemCount: images.length,
                itemBuilder: (context,count){
                  return images[count];
                },
            //layout: SwiperLayout.STACK,
            pagination: new SwiperPagination(),
            control: new SwiperControl(
              color: Colors.blue,
              disableColor: Colors.green,
            ),
            loop: false,
            onTap: (int index){
              print("onTap : "+index.toString());
            },
            onIndexChanged: (index){
              commentController.clear();
              commentController.text= commentsMap[files[index].name];
              i=index;
            },
          ),
        ),
        Container(
          //color: Colors.teal,
          width: 200,
          margin: EdgeInsets.fromLTRB(50, 0, 20, 0),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 20),),
              Container(
                child: RaisedButton(
                  child:Text(thumbnail),
                  onPressed: () async{

                    FilePickerResult result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg','png','jpeg' ],
                    );
                    if(result != null) {
                      thumbnailFile = result.files.first;
                      if(thumbnailFile.extension == 'jpg' || thumbnailFile.extension == 'png' || thumbnailFile.extension == 'jpeg' )
                      {
                        print(thumbnailFile.name);
                        print(thumbnailFile.size);
                        print(thumbnailFile.extension);
                        setState(() {
                          thumbnail = thumbnailFile.name;                              
                        });
                      }
                      else{
                        print('file is not img');
                      }
                      
                    } else {
                      // User canceled the picker
                      print('result is null');
                    }
                    // final _image = await FlutterWebImagePicker.getImage;
                    // //ms[_image.semanticLabel] = _image;
                    // setState(() {
                    //   //print(_image.toString());
                    //   thumbnailImage = _image;
                    //   thumbnail = _image.semanticLabel;          
                    // });
                  },
                ),
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 20),),
              Container(
                child: RaisedButton(
                  child:Text('이미지 선택'),
                  onPressed:  () async{
                    FilePickerResult result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg','png','jpeg' ],
                    );

                    if(result != null) {
                      PlatformFile file = result.files.first;
                      

                      if(file.extension == 'jpg' || file.extension == 'png' || file.extension == 'jpeg' )
                      {
                        print(file.name);
                        // print(file.bytes);
                        print(file.size);
                        print(file.extension);
                        //print(file.path);
                        
                        
                        //ms[_image.semanticLabel] = _image;
                        setState(() {
                          files.add(file);
                          var img = Image(image: MemoryImage(file.bytes),);

                          images.add(img);
                          imagesMap[file.name] = img;
                                    
                        });
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
              ),
              Expanded(
                flex: 1,
                child: Divider(
                  thickness: 5,
                ),
              ),
              TextField(
                controller: commentController,
                maxLines: 7,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "이미지에 대한 설명"
                ),
                onChanged: (value) {
                  commentsMap[files[i].name] = value;
                },                
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildComment(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField( 
          controller: explainController,
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "포스트에 대한 설명",
          ),
        ),
        Padding(padding: EdgeInsets.all(20),),
        Container(
          width: 300,
          child: TextField( 
          controller: linkController,
          maxLines: 1,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "링크 설정",
          ),
        ),
        )

      ],
    );
  }
  
  Widget buildSubmitBtn(UserLogin userLogin) {
    //print(idTextBoxController.text.toString());
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          posting(userLogin.getMe().nickname);
          Navigator.of(context).pop();
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // color: Colors.white,
        color: Color(0xFF0275D8),
        child: Text('작성',
          style: TextStyle(
            color: Color(0xFFAFD9FE),
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
        
      ),
    );
  }



  posting(String nickname) async{
    List<MultipartFile> imageList = List<MultipartFile>();
    List<String> comments = List<String>();
    //List<String> imageExplain = List<String>();
    String uri = "https://rest-api-server-axfra.run.goorm.io/api/posting";

    print(nickname+">>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    //사용자가 선택한 파일들을 byte로 바꿔서 MultipartFile형식으로 변환
    for(var imgs in files){
      List<int> imageData = imgs.bytes;

      MultipartFile multipartFile = MultipartFile.fromBytes(
        imageData,
        filename: imgs.name,
        contentType: MediaType('image',imgs.extension)
      );
      imageList.add(multipartFile);
      //imageList[multipartFile] = commentsMap[imgs.name];
    }
    print("Number of pictures:${imageList.length}");
    
    //사용자가 작성한 이미지에 대한 설명을 list에 옮김
    commentsMap.forEach((key, value) {
      print(key+ ":" + value);
      comments.add(value);
    });
    
   
    FormData formData = FormData.fromMap({
      'title' : titleController.text,
      'writer' :  nickname,
      'multipartFiles' : imageList,
      'comments' : comments,
      'explanation' : explainController.text,
      'link' : linkController.text
    });

    print(formData.fields.toString());

    Dio dio = Dio();
    var response = await dio.post(uri, data: formData,); //options: Options(contentType:  Headers.formUrlEncodedContentType)

    print(response.data.toString());
    print(response.statusCode.toString());
    print(response.headers.toString());
    
    
    
  }


}