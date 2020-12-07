import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:textfield_tags/textfield_tags.dart';


class EditPage extends StatefulWidget{
  @override
  EditPageState createState() => EditPageState();
}


class EditPageState extends State<EditPage>{
  Image currentImage;
  
  List<Image> images = List<Image>();
  Map<String, Image> imagesMap = Map<String, Image>(); //이미지라밸이 key

  List<String> comments = List<String>();
  Map<String,String> commentsMap = Map<String,String>(); //이미지라밸이 key

  TextEditingController commentController = TextEditingController(); 

  List<String> tags = List<String>();
  // @override
  // void initState() {
  //   ms['default'] = image;
    
  // }
  int i =0;

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
              imagesMap[_image.semanticLabel] = _image;          
            });
          },
        ),
        body: Column(
          children: [
            Align(
              child: IconButton(
                  iconSize: 20,
                  icon: Icon(Icons.cancel_outlined),
                  onPressed: () => Navigator.of(context).pop(),
              ), 
              alignment: FractionalOffset(1, 0),
            ),
            Flexible(
              flex: 1,
              child: Swiper(
                // layout: SwiperLayout.STACK,
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
                onTap: (int index){
                  print("onTap : "+index.toString());
                },
                onIndexChanged: (int index) {
                  currentImage = images[i];
                  commentsMap[currentImage.semanticLabel] = commentController.text;
                  commentController.clear();
                  commentController.text = commentsMap[images[index].semanticLabel];
                  i=index;
                },
              ),
            ),
            Flexible(
              child: TextField(controller: commentController,), 
            ),
            Flexible(
              flex: 1,
              child: TextFieldTags(
                textFieldStyler: TextFieldStyler(
                  hintText: "Vz",
                  helperText: "엔터누르삼",
                  cursorColor: Colors.orangeAccent,
                  // textFieldFocusedBorder: ,
                  textFieldBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(color: Colors.purple)
                  ),
                  textFieldFocusedBorder: OutlineInputBorder(
                    gapPadding: 10,
                    borderSide: BorderSide(color: Colors.purple)
                  ),
                  textFieldFilledColor: Colors.red,
                  textFieldFilled: true
                ),
                tagsStyler: TagsStyler(
                  tagTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  tagDecoration: BoxDecoration(
                    color: Colors.deepPurpleAccent[700],
                    borderRadius: BorderRadius.circular(7)
                  ),
                  tagCancelIcon: Icon(
                    Icons.cancel,
                    color: Colors.white,
                  )
                ),
                onTag: (tag) {
                  //This give you tags entered
                  print('onTag ' + tag);
                  tags.add(tag);
                  print(tags.toString());
                },
                onDelete: (tag) {
                  print('onDelete ' + tag);
                  tags.remove(tag);
                  print(tags.toString());
                },

              )
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