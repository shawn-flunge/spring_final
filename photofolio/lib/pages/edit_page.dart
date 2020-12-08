import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'dart:io' as Io;


class EditPage extends StatefulWidget{
  @override
  EditPageState createState() => EditPageState();
}


class EditPageState extends State<EditPage>{
  Image currentImage;
  Image thumbnailImage;
  
  List<Image> images = List<Image>();
  Map<String, Image> imagesMap = Map<String, Image>(); //이미지라밸이 key

  List<String> comments = List<String>();
  Map<String,String> commentsMap = Map<String,String>(); //이미지라밸이 key

  TextEditingController commentController = TextEditingController(); 
  TextEditingController explainController = TextEditingController(); 

  List<String> tags = List<String>();

  int i =0;
  var thumbnail = "섬네일 설정";

  @override
  Widget build(BuildContext context) {
    

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
            child: RaisedButton(
              child: Text('submit'),
              onPressed: (){
                // images[0].semanticLabel
              },
            ),
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
          color: Colors.deepPurple,
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
              color: Colors.pink,
              disableColor: Colors.green,
            ),
            //loop: false,
            onTap: (int index){
              print("onTap : "+index.toString());
            },
            onIndexChanged: (index){
              currentImage = images[i];
              commentsMap[currentImage.semanticLabel] = commentController.text;
              commentController.clear();
              commentController.text = commentsMap[images[index].semanticLabel];
              i=index;
            },
          ),
        ),
        Container(
          color: Colors.teal,
          width: 200,
          margin: EdgeInsets.fromLTRB(50, 0, 20, 0),
          child: Column(
            children: [
              
              Container(
                child: RaisedButton(
                  child:Text(thumbnail),
                  onPressed: () async{
                    final _image = await FlutterWebImagePicker.getImage;
                    //ms[_image.semanticLabel] = _image;
                    setState(() {
                      //print(_image.toString());
                      thumbnailImage = _image;
                      thumbnail = _image.semanticLabel;          
                    });
                  },
                ),
              ),
              Container(
                child: RaisedButton(
                  child:Text('이미지 선택'),
                  onPressed:  () async{
                    final _image = await FlutterWebImagePicker.getImage;
                    //ms[_image.semanticLabel] = _image;
                    setState(() {
                      //print(_image.toString());
                      currentImage = _image;
                      images.add(_image);
                      imagesMap[_image.semanticLabel] = _image;          
                    });
                  },
                ),
              ),
              TextField(
                controller: commentController,
                maxLines: 7,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "이미지에 대한 설명"
                ),
                
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
          controller: explainController,
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
  


}