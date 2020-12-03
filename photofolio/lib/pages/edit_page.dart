


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class EditPage extends StatefulWidget{
  @override
  EditPageState createState() => EditPageState();
}


class EditPageState extends State<EditPage>{
  Image currentImage;
  
  List<Image> images = List<Image>();
  Map<String, Image> maps = Map<String, Image>(); //이미지라밸이 key

  Map<String,String> comments = Map<String,String>(); //이미지라밸이 key

  TextEditingController commentController = TextEditingController(); 

  // @override
  // void initState() {
  //   ms['default'] = image;
    
  // }


  @override
  Widget build(BuildContext context) {
    
    

    return MaterialApp(
      home: Scaffold( 
        floatingActionButton: FloatingActionButton(
          child: Text('ff'),
          onPressed: () async{
            final _image = await FlutterWebImagePicker.getImage;
            //ms[_image.semanticLabel] = _image;
            setState(() {
              //print(_image.toString());
              currentImage = _image;
              images.add(_image);
              maps[_image.semanticLabel] = _image;
            });
          },
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Swiper(
                itemCount: images.length,
                itemBuilder: (context,count){
                  // print(count.toString() + "vvvvvvvvvvvv");
                  // print(images[count].semanticLabel);
                  // print(maps.length.toString()+"&&&&&&&&&&&&&&&&&");
                  // print(MediaQuery.of(context).size.width*0.2);
                  return images[count];
                },
                pagination: new SwiperPagination(),
                control: new SwiperControl(
                  color: Colors.pink,
                  disableColor: Colors.green,
                ),
                loop: false,
                onIndexChanged: (int index) {
                  
                  commentController.text = comments[currentImage.semanticLabel];
                  currentImage = images[index];
                  print('sdafsfdaf\t'+index.toString()+'\t' + currentImage.semanticLabel);
                  comments[currentImage.semanticLabel] = commentController.text;
                  print(comments.toString());
                  //commentController.clear();
                  
                  
                },
              ),
            ),
            Flexible(
              child: TextField(controller: commentController,),
              
            ),
            Flexible(
              child: RaisedButton(
                child: Text('finish'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            )
          ],
        )
      ),
    );
    
  }

  


}