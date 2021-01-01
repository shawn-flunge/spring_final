import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photofolio/store/User.dart';

import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {

  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  final formKey = GlobalKey<FormState>();

  TextEditingController emailTextBoxController = TextEditingController();
  TextEditingController nickTextBoxController= TextEditingController();
  TextEditingController pwdTextBoxController= TextEditingController();
  TextEditingController pwdCkTextBoxController= TextEditingController();

  var mediaQueryWidth; 
  var mainPadding;

  var me=User();
  
  @override
  Widget build(BuildContext context) {
    
    //mediaQueryWidth = MediaQuery.of(context).size.width;

    if(MediaQuery.of(context).size.width > 1000){
      mediaQueryWidth = 900;
      mainPadding = MediaQuery.of(context).size.width*0.1;
    }
    else
    {
      mediaQueryWidth = 500;
      mainPadding = MediaQuery.of(context).size.width*0.1;
    }
      

    print(MediaQuery.of(context).size.width.toString() + "------" + mediaQueryWidth.toString());
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.fromLTRB(mainPadding, 10 , mainPadding, 10),
      child: Container(
        // height: 500,
        // width: mediaQueryWidth,
        margin: EdgeInsets.all(100),
        //color: Colors.blue,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
          ]
        ),
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: formKey,
              child: inputColumn(context),
            ),
            buildImage(),
            //inputColumn(context)
            //buildId(context)
            
          ],
        ),
      ),
    );
  }


  Widget inputColumn(BuildContext context){

    return Container(
      width: mediaQueryWidth*0.5,
      //color: Colors.pink,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 20),),
          Text('PHOTOFOLIO',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 15),),
          buildEmail(context),
          Padding(padding: EdgeInsets.symmetric(vertical: 15),),
          buildNick(context),
          Padding(padding: EdgeInsets.symmetric(vertical: 15),),
          buildPassword(context),
          Padding(padding: EdgeInsets.symmetric(vertical: 15),),
          buildPasswordCheck(context),
          Padding(padding: EdgeInsets.symmetric(vertical: 8),),
          buildSignUpBtn()
        ],
      ),
    );

  }

  Widget buildEmail(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: <Widget>[
        Text(
          'email',
          style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]
          ),
          height: 60,
          width: mediaQueryWidth*0.4,
          //child: Text('text'),
          child: TextFormField(
            validator: (value){
              if(!value.contains('@'))
                return "이메일 형식을 맞추세요";
              return null;
            },
            controller: emailTextBoxController,
            onChanged: (value) => {
                me.eMail=value,
              },//userID = value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.email,//Icons.account_circle,
                color: Color(0xFF81C0D5),
              ),
              hintText: 'Email',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

   Widget buildNick(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      
      children: <Widget>[
        Text(
          '닉네임',
          style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]
          ),
          height: 60,
          width: mediaQueryWidth*0.4,
          //child: Text('text'),
          child: TextField(
            controller: nickTextBoxController,
            onChanged: (value) => {me.nickname=value},//userID = value,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.account_circle,//Icons.account_circle,
                color: Color(0xFF81C0D5),
              ),
              hintText: 'NickName',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '비밀번호',
          style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          width: mediaQueryWidth*0.4,
          child: TextFormField(
            validator: (value){
              if(value.length<5)
                return "4자리 이상입력하세요";
              return null;
            },
            controller: pwdTextBoxController,
            onChanged: (value) =>  {me.password=value},//userPassword = value,
            obscureText: true,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFF81C0D5),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        )
      ],
    );
  }



  Widget buildPasswordCheck(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '비밀번호 확인',
          style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          width: mediaQueryWidth*0.4,
          child: TextFormField(
            validator: (value){
              if(value != pwdTextBoxController.text)
                return "비밀번호 확인하세요";
              return null;
            },
            controller: pwdCkTextBoxController,
            onChanged: (value) =>  {me.password=value},//userPassword = value,
            obscureText: true,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xFF81C0D5),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        )
      ],
    );
  }

  Widget buildImage(){

    // return Container(
    //   width: mediaQueryWidth*0.2,
    //   color: Colors.blue,
    //   child: Image(
    //     image: ,
    //   ),
    // );

    return SizedBox(
      width: mediaQueryWidth*0.3,
      child: Image.asset('assets/signup_img.jpg'),
    );


  }


  Widget buildSignUpBtn() {
    var raisedButton = RaisedButton(
        elevation: 5,
        onPressed: () async{
          // if(formKey.currentState.validate())

          if(formKey.currentState.validate() && (emailTextBoxController.text != "") && (nickTextBoxController.text != ""))
          {
            String result;
            final res=await http.post('https://rest-api-server-axfra.run.goorm.io/api/signUp',body:me.toJson(),headers:{'Content-Type':'application/json'});
            print(res.body);
            result=res.body;
            if(result == 'Nick Duplicate'){ // 중복 되었을 때 알림을 띄어주어요!
              print('닉네임 중복입니다!');
              showErrorDialog(context,'닉네임 중복입니다!');
            }else if(result =='Email Duplicate'){
              print('이메일 중복입니다!');
              showErrorDialog(context,'이메일 중복입니다!');
            } else{
              Navigator.of(context).pop();
            }
          }
          else if(emailTextBoxController.text == "")
            showErrorDialog(context, '이메일을 입력하세요');
          else if(nickTextBoxController.text == "")
            showErrorDialog(context, '닉네임을 입력하세요');
          
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // color: Colors.white,
        color: Color(0xFF0275D8),
        child: Text('회원 가입',
          style: TextStyle(
            color: Color(0xFFAFD9FE),
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
      );
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: mediaQueryWidth*0.3,
      child: raisedButton,
    );
  }


  showErrorDialog(BuildContext context,String str){
    showDialog<void>(
      context: context,
      builder: (context){
        return AlertDialog(
          actions: [
            RaisedButton(
              child: Text('확인'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
          content: Text(str),
        );
      }
    );
  }


}

