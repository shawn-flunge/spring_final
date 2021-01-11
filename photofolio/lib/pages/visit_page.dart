import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:photofolio/pages/edit_page.dart';
import 'package:photofolio/pages/post_page.dart';
import 'package:photofolio/pages/rich_edit_page.dart';
import 'package:photofolio/pages/setting_page.dart';
import 'package:photofolio/provider/post_provider.dart';
import 'package:photofolio/provider/user_provider.dart';
import 'package:photofolio/routes/routes.dart';
import 'package:photofolio/store/post.dart';
import 'rich_edit_page.dart';
import 'package:provider/provider.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';


class VisitPage extends StatefulWidget{
  VisitPageState createState() => VisitPageState();
}



class VisitPageState extends State<VisitPage> with TickerProviderStateMixin{

  TabController tabController;

  TextEditingController introduceController;
  QuillController quillController = QuillController.basic();
  
  List<String> ss = ['ff','gg','ewerqrq','vvv','zzz','qqq','tt'];
  List<ActionChip> chips = List<ActionChip>();

  String nickname;
  String imgPath;
  String infoText;
  
  Future<List<Post>> fetchActivity(String nickname) async{
    print('start fetch');
    FormData formData = FormData.fromMap({
      'nickname' : nickname,
      'tag' : 'none'
    });
    Dio dio = Dio();

    var response = await dio.post(baseUrl+'/about', data: formData,); //options: Options(contentType:  Headers.formUrlEncodedContentType, responseType: ResponseType.plain)

    if(response.statusCode ==200){
      var data = response.data as Map<String, dynamic>;
      List<Post> posts = List<Post>();
      data.forEach((key, value) {
        var thumbnail = value['thumbnail'].toString().split('/');
        var realThumbnail = imageUrl+'/' + thumbnail[9];
        posts.add(new Post(id: value['id'],
          postTitle: value['title'],
          postThumbNail: realThumbnail,
          userNickname: value['nickname'],
          postExplain: value['explanation'],
          postLink: value['link']
        ));
        
      });
      return posts;
    }
  }

  @override
  void initState() {
    super.initState();
    tabController= TabController(length: 3,vsync: this);
    
  }

  @override
  Widget build(BuildContext context) {

    //chip
    // for(int i=0;i<ss.length;i++){
    //   chips.add(
    //     ActionChip(
    //       label: Text(ss[i]),
    //       avatar: Icon(Icons.check),
    //       backgroundColor: Colors.cyan,
    //       onPressed: (){print(ss[i]);},
    //     )
    //   );
    // }

    UserProvider userProvider = Provider.of<UserProvider>(context);
    PostProvider postProvider = Provider.of<PostProvider>(context);
    

    return SingleChildScrollView(

      child: Column(
        children: [
          buildUserInfoSection(context,userProvider),
          const Divider(
            color: Colors.black38,
            height: 30,
            thickness: 2,
            indent: 200,
            endIndent: 200,
          ),
          
          // Container(
          //   margin: EdgeInsets.fromLTRB(200, 10, 200, 10),
          //   color: Colors.pink,
          //   height: 1000,
          //   child: buildUserActivitySection(userLogin, postProvider),
          // ),
          Container(
            margin: EdgeInsets.fromLTRB(200, 10, 200, 10),
            // child: buildUserActivitySection(userLogin, postProvider),
            child: FutureBuilder<List<Post>>(
              future: fetchActivity(userProvider.getFriend().nickname),
              builder: (context, snapshot){
                return snapshot.hasData ? buildUserActivitySection(userProvider,postProvider,snapshot.data) : Text('ff');
              },
            ),
          )
          
        ],
      )


    );

  }


  Widget buildUserInfoSection(BuildContext context, UserProvider userProvider) {
    return Container(
      margin: EdgeInsets.fromLTRB(200, 10, 200, 10),
      color: Colors.grey[100],
      padding: EdgeInsets.fromLTRB(200, 50, 200, 30),
      
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //프로필사진, 아이디, 간단 소개
          Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircleAvatar(  
                      // backgroundImage: temp.isProfile == false ? Image.asset('../assets/none.png').image : Image.asset('../assets/lee.png').image,
                      backgroundImage: Image.network(userProvider.getFriend().imgPath ,fit: BoxFit.contain,).image,
                      //backgroundImage: Image.network('https://picsum.photos/250?image=9').image,
                      backgroundColor: Color(0xFFFFFFFF),
                    ),
                  ),
                  // Container(
                  //   width: 200,
                  //   child: Wrap(
                  //     children: ac,
                  //   ),
                  // ),
                  
                ],
              ),
              
              Padding(padding: EdgeInsets.all(30),),
              Container(
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                  children: <Widget>[           
                    Container(
                      // color: Colors.pink,
                      child: Text(
                        userProvider.getFriend().nickname == null ? "":userProvider.getFriend().nickname,
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    Container(
                      //color: Colors.pink,
                      child: Text(
                        userProvider.getFriend().infoText == null ?"":userProvider.getFriend().infoText
                        // userLogin.getMe().infoText ==null ?"" : userLogin.getMe().infoText,
                        // temp.isIntro == false ? "" : "안녕하세요"
                      ),
                    )                           
                  ],
                ),
              )
              
            ],
          ),
          Padding(padding: EdgeInsets.all(30),),
          //팔로우, 팔로워       
        ],
      ),
    );
  }

  Widget buildUserActivitySection(UserProvider userProvider, PostProvider postProvider, List<Post> posts){
    return Container(
      height: 1000,
      child:Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          children: <Widget>[
            TabBar(
              indicator: ColorTabIndicator(Colors.blueGrey[100]),
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Activity',),
                Tab(text: 'Story',),
                Tab(text: 'Me',),
              ],
              controller: tabController,
            ),
            Expanded(  //222222222222222222222222222222222222222222222222222222222
              child: ExtendedTabBarView(
                children: <Widget>[
                  buildGrid(posts,postProvider),
                  Text('Story service comes soon'),
                  Text('Me service comes soon'),
                ],
                controller: tabController,
              ),
            )
          ],
        ),
      )
    );

  }

  Widget buildGrid(List<Post> posts, PostProvider postProvider){
    return GridView.builder(
      padding: EdgeInsets.all(30),
      physics: ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return buildCard(context, posts[index], postProvider);
      },
    ); 
   
  }

  Widget buildCard(BuildContext context, Post post, PostProvider postProvider){
    return Container(
      //margin: EdgeInsets.all(50),
      //padding: EdgeInsets.all(50),
      
      child: InkWell(
        child: Card(
          margin: EdgeInsets.all(20),      
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(post.postTitle),
                subtitle: Text(
                  post.userNickname,
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              Expanded(
                flex: 1,
                child: Image(
                  image: Image.network(post.postThumbNail,fit: BoxFit.fill,).image,
                  width: double.maxFinite,         
                ),
              ),        
            ],
          ),
        ),
        onTap: (){
          print(post.id.toString() + "###################");
          postProvider.selectPost(post);
          showPostDialog(context);
        },
      ),
    );

  }

  
  Widget buildEditor(){
    
    return Column(
      children: [
        QuillToolbar.basic(
            controller: quillController, ), //uploadFileCallback: _uploadImageCallBack
        Expanded(
          child: Container(
            child: QuillEditor.basic(
              controller: quillController,
              readOnly: false, // change to true to be view only mode
            ),
          ),
        )
      ],
    );
  }

  showRichEditorDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      barrierColor: Colors.blue.withAlpha(70),
      transitionDuration: new Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: 'ff',
      pageBuilder: (BuildContext con, Animation ani, Animation secAni){
        return AlertDialog(
          elevation: 10,
          //backgroundColor: Colors.yellow,
         // contentPadding: EdgeInsets.zero,
          // content: Container(
          //   width: MediaQuery.of(context).size.width*0.4,
          //   child: LoginPage(),
          // )
          content: Container(
            width: MediaQuery.of(context).size.width*0.3,
            child: RichEditor()
          )
        );
      }

    );
  }

  showPostDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.pink[500].withAlpha(30),
      barrierLabel: "show post" ,
      transitionDuration: new Duration(seconds: 1),
      
      pageBuilder: (BuildContext con, Animation ani, Animation secAni){
        
        return AlertDialog(
          elevation: 10,
       
          contentPadding: EdgeInsets.zero,
          content: 
          Container(
            width: MediaQuery.of(context).size.width*0.6,
            child: PostPage(),
          )
        );
      }

    );
  }


}




