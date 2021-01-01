


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class PostPage extends StatefulWidget{

  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage>{

  TextEditingController commentController = TextEditingController();
  TextEditingController imgTextController = TextEditingController();

  Image img = Image.network('https://picsum.photos/250?image=9');
  Image img2 = Image.network('https://picsum.photos/250?image=9');

  // List<Image> imgs = [Image.network('https://picsum.photos/250?image=9',fit: BoxFit.scaleDown,),Image.network('https://picsum.photos/250?image=9',fit: BoxFit.fitWidth)];
  List<Image> imgs = [Image.asset('../assets/pupple.png'),Image.asset('../assets/yellow.png'),Image.asset('../assets/red.png')];
  List<String> strs = ['보라','노랑','빨강'];


  @override
  Widget build(BuildContext context) {

    imgTextController.text = strs[0];

    return SingleChildScrollView(

      child: Column(

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
          Container(
            //color: Colors.deepPurple,
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: buildTitle(),
          ),
          Container(
            //color: Colors.indigo,
            width: double.infinity,
            height: 500,
            child: buildImageRow(),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            child: buildComment(),
          )

        ],
      ),
    );
    

  }

  Widget buildTitle(){
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'flutter와 spring boot로 만드는spring photofolio',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),
        ),
        Container(
          child: Row(
            children: [
              //Icon(Icons.account_circle_outlined),
              TextButton(
                child: Text('flunge',
                  style: TextStyle(
                    fontSize: 20
                  ),  
                ),    
                autofocus: false,
                clipBehavior: Clip.none,
                onPressed: (){
                  print('asg');
                  Navigator.of(context).pushNamed(routeAbout);
                },
              )
            ],
          ),
        )


      ],
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
            itemCount: imgs.length,
            itemBuilder: (context, count){
              return imgs[count];
            },
            //layout: SwiperLayout.STACK,
            pagination: new SwiperPagination(),
            control: new SwiperControl(
              color: Colors.blue,
              disableColor: Colors.green,
            ),
            //loop: false,
            onTap: (int index){
              print("onTap : "+index.toString());
            },
            onIndexChanged: (index){
             imgTextController.text=strs[index];
            },
          ),
        ),
        Container(
          width: 200,
          margin: EdgeInsets.fromLTRB(10, 20, 20, 10),
          child: TextField(
            controller: imgTextController,
            maxLines: 7,
            readOnly: true,

          ),
        )
      ],
    );
  }

  Widget buildComment(){
    commentController.text="디자인작업 끝나고 서비스 시작합니다!";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          
          controller: commentController,
          readOnly: true,
          maxLines: 4,
        ),
        InkWell(
          child: Text('https://github.com/shawn-flunge'),
          onTap: () => launch('https://github.com/shawn-flunge'),
        ),
        Padding(padding: EdgeInsets.all(50),)
      ],
    );
  }




}