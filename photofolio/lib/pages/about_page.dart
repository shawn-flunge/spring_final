import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:photofolio/pages/edit_page.dart';
import 'package:photofolio/pages/post_page.dart';
import 'package:photofolio/pages/rich_edit_page.dart';
import 'package:photofolio/pages/setting_page.dart';
import 'package:photofolio/provider/user_provider.dart';
import 'rich_edit_page.dart';
import 'package:provider/provider.dart';
import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter_quill/widgets/controller.dart';
import 'package:flutter_quill/widgets/editor.dart';
import 'package:flutter_quill/widgets/toolbar.dart';


class AboutPage extends StatefulWidget{
  AboutPageState createState() => AboutPageState();
}



class AboutPageState extends State<AboutPage> with TickerProviderStateMixin{

  TabController tabController;

  TextEditingController introduceController;

  

  List<String> ss = ['ff','gg','ewerqrq','vvv','zzz','qqq','tt'];
  // var ac= <ActionChip>[];
  List<ActionChip> ac = List<ActionChip>();
  
  @override
  void initState() {
    super.initState();
    tabController= TabController(length: 2,vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    for(int i=0;i<ss.length;i++){
      ac.add(
        ActionChip(
          label: Text(ss[i]),
          avatar: Icon(Icons.check),
          backgroundColor: Colors.cyan,
          onPressed: (){print(ss[i]);},
        )
      );
    }


    UserLogin userLogin = Provider.of<UserLogin>(context);
    if(userLogin.getIsLogin())
    {
      print('no login');
    }
    else{

    }

    //introduceController.text ="sgg";
    return Scaffold(

      body: ListView(
        children: [
          buildUserInfoSection(context,userLogin),
          const Divider(
            color: Colors.black38,
            height: 30,
            thickness: 2,
            indent: 200,
            endIndent: 200,
          ),
          
          Container(
            margin: EdgeInsets.fromLTRB(200, 10, 200, 10),
            color: Colors.pink,
            //width: 1000,
            height: 2000,
            child: buildUserActivitySection(),
          )
          
        ],
      )


    );

  }


  Widget buildUserInfoSection(BuildContext context, UserLogin userLogin) {
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
                    child: CircleAvatar(  //NetworkImage('https://picsum.photos/250?image=9')
                      // backgroundImage: temp.isProfile == false ? Image.asset('../assets/none.png').image : Image.asset('../assets/lee.png').image,
                      backgroundColor: Color(0xFFFFFFFF),
                    ),
                  ),
                  // Container(
                  //   width: 200,
                  //   child: Wrap(
                  //     children: ac,
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: RaisedButton(
                      child: Text("글쓰기"),
                      onPressed: (){
                        showEditPostDialog(context);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: RaisedButton(
                      child: Text("편집"),
                      onPressed: (){
                        showSettingDialog(context);
                      },
                    ),
                  )
                  
                  

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
                        userLogin.getMe().nickname == null ? "":userLogin.getMe().nickname,
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    Container(
                      //color: Colors.pink,
                      child: Text(
                        userLogin.getMe().infoText == null ?"":userLogin.getMe().infoText
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

  Widget buildUserActivitySection(){
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        children: <Widget>[
          TabBar(
            indicator: ColorTabIndicator(Colors.blueGrey[100]),
            labelColor: Colors.black,
            tabs: [
              Tab(text: '소개',),
              Tab(text: '활동',),
            ],
            controller: tabController,
          ),
          Expanded(
            child: ExtendedTabBarView(
              children: <Widget>[
                Text('00'),
                RaisedButton(
                  child: Text('edit'),
                  onPressed: () {
                    showRichEditorDialog(context);
                  },
                )
              ],
              controller: tabController,
            ),
          )
        ],
      ),
    );

  }


  QuillController quillController = QuillController.basic();
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


  showEditPostDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.pink[500].withAlpha(30),
      barrierLabel: "ff" ,
      transitionDuration: new Duration(seconds: 1),
      
      pageBuilder: (BuildContext con, Animation ani, Animation secAni){
        
        return AlertDialog(
          elevation: 10,
       
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.of(context).size.width*0.6,
            child: EditPage(),
          )
        );
      }

    );
  }

  showPostDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.pink[500].withAlpha(30),
      barrierLabel: "ff" ,
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

  showSettingDialog(BuildContext context){
    return showGeneralDialog(
      context: context,
      
      barrierColor: Colors.blue.withAlpha(70),
      transitionDuration: new Duration(milliseconds: 400),
      //barrierDismissible: false,
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
            child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            //width: MediaQuery.of(context).size.width*0.4,
            child: Column(
              children: [
                Align(
                  child: IconButton(
                      iconSize: 20,
                      icon: Icon(Icons.cancel_outlined,),
                      onPressed: () => Navigator.of(context).pop(),
                  ), 
                  alignment: FractionalOffset(1, 0),
                ),
                SettingPage()
              ],
            ),
          ),
          )
        );
      }

    );
  }



}




