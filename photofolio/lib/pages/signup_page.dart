

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photofolio/store/User.dart';

class SignUpPage extends StatefulWidget{

  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage>{

  TextEditingController idTextBoxController;
  TextEditingController pwTextBoxController;
  TextEditingController pwCkTextBoxController;

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
            inputColumn(context),
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
          Text('logo'),
          buildEmail(context),
          buildNick(context),
          buildPassword(context),
          buildPasswordCheck(context),
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
          height: 50,
          width: mediaQueryWidth*0.4,
          //child: Text('text'),
          child: TextField(
            controller: idTextBoxController,
            onChanged: (value) => {me.userEmail=value},//userID = value,
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
          height: 50,
          width: mediaQueryWidth*0.4,
          //child: Text('text'),
          child: TextField(
            controller: idTextBoxController,
            onChanged: (value) => {me.userNickName=value},//userID = value,
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
          height: 50,
          width: mediaQueryWidth*0.4,
          child: TextField(
            controller: pwTextBoxController,
            onChanged: (value) =>  {me.userPassword=value},//userPassword = value,
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
          height: 50,
          width: mediaQueryWidth*0.4,
          child: TextField(
            controller: pwTextBoxController,
            onChanged: (value) =>  {me.userPassword=value},//userPassword = value,
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
      width: mediaQueryWidth*0.2,
      child: Image.asset('assets/signup_img.jpg'),
    );


  }


  Widget buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: mediaQueryWidth*0.3,
      child: RaisedButton(
        elevation: 5,
        onPressed: () {
          Navigator.of(context).pop();
          User.infoPrint(me);
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
      ),
    );
  }



}