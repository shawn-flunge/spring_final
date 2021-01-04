


import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:photofolio/provider/post_provider.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:photofolio/store/PostImage.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PostPage extends StatefulWidget{

  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage>{

  TextEditingController commentController = TextEditingController();
  TextEditingController imgTextController = TextEditingController();

  Image img = Image.network('https://picsum.photos/250?image=9');
  Image img2 = Image.network('https://picsum.photos/250?image=9');


  List<Image> imgs = List<Image>();
  List<String> comments =List<String>();

  Map<int,PostImage> map = Map<int,PostImage>();

  Future<String> fetchPost(PostProvider postProvider) async{
    print('searching post image');
    FormData formData = FormData.fromMap({
      'id' : postProvider.getSelectedPost().id
    });
    Dio dio = Dio();

    var response = await dio.post(baseUrl+'/post', data: formData,); //options: Options(contentType:  Headers.formUrlEncodedContentType, responseType: ResponseType.plain)
 
    if(response.statusCode == 200){
      var data = response.data as Map<String, dynamic>;

      print(data.toString());
      print(data.runtimeType);
      map = Map<int,PostImage>();
      data.forEach((key, value) {
        map[int.parse(key)] = PostImage(value['img'],value['comment']);
        var imgPath = imageUrl+'/' + value['img'].toString().split('/')[9];
        imgs.add(Image.network(imgPath));
        comments.add(value['comment']);
        print(key + '////' + value['comment']);
      });
      print(comments.length);
      for(int i=0; i<comments.length;i++){
        print(comments[i].toString()+'@@@@@@@@@@@@');
      }

    }
    return "ok";
  }


  @override
  Widget build(BuildContext context) {
    PostProvider postProvider = Provider.of<PostProvider>(context);
    print(postProvider.getSelectedPost().toString() + "@@@@@@@@@@@@@@@@@");

    return FutureBuilder(
      future: fetchPost(postProvider),
      builder: (context, snapshot){
        if(snapshot.hasData == false)
          return Text('false');
        else if(snapshot.hasError){
          return Text('error : ' +snapshot.error);
        }
        else{
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
                  child: buildTitle(postProvider),
                ),
                Container(
                  //color: Colors.indigo,
                  width: double.infinity,
                  height: 500,
                  child: buildImageRow(postProvider),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  child: buildComment(postProvider),
                )

              ],
            ),
          );
        }
         
      },
    );


    

  }

  Widget buildTitle(PostProvider postProvider){
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          postProvider.getSelectedPost().postTitle,
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
                child: Text(postProvider.getSelectedPost().userNickname,
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

  Widget buildImageRow(PostProvider postProvider){
    imgTextController.text = comments[0];
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
             imgTextController.text = comments[index];
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

  Widget buildComment(PostProvider postProvider){
    commentController.text=postProvider.getSelectedPost().postExplain;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          
          controller: commentController,
          readOnly: true,
          maxLines: 4,
        ),
        InkWell(
          child: Text(postProvider.getSelectedPost().postLink),
          onTap: () => launch('https://github.com/shawn-flunge'),
        ),
        Padding(padding: EdgeInsets.all(50),)


      ],
    );
  }




}