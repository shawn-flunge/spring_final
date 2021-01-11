


import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photofolio/pages/signup_page.dart';
import 'package:photofolio/provider/user_provider.dart';
import 'package:photofolio/routes/routes.dart';

class LoginPage extends StatefulWidget{
  UserProvider userProvider;
  LoginPage(this.userProvider);
  LoginPageState createState() => LoginPageState(userProvider);  
}


class LoginPageState extends State<LoginPage>{

  UserProvider userProvider;
  LoginPageState(this.userProvider);

  TextEditingController idTextBoxController;
  TextEditingController pwdTextBoxController;

  double marginWidth;
  
  @override
  void initState() {
    // TODO: implement initState
    idTextBoxController = TextEditingController();
    pwdTextBoxController = TextEditingController();
  }

  

  @override
  Widget build(BuildContext context) {
    
    if(MediaQuery.of(context).size.width>500){
      marginWidth = 60;
    }
    else{
      marginWidth = 15;
    }

    return Container(
      margin: EdgeInsets.fromLTRB(marginWidth, 0, marginWidth, 30),
      child: Column(
        children: [
          
          Text('PHOTOFOLIO',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: 10,),
          buildId(context),
          SizedBox(height: 10,),
          buildPassword(context),
          SizedBox(height: 10,),
          buildLoginBtn(),
          SizedBox(height: 10,),
          Divider(
            thickness: 2,
            endIndent: 20,
            indent: 20,
          ),
          buildCABtn(context)
          
        ],
      ),
    );
    
  }



  Widget buildId(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '이메일',
          style: TextStyle(
              color: Colors.blueGrey[300],
              fontSize: 13,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
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
          child: TextField(
            controller: idTextBoxController,
            onChanged: (value) => {},//userID = value,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.account_circle,
                color: Color(0xFF81C0D5),
              ),
              hintText: 'ID',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        )
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
          height: 10,
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
          child: TextField(
            controller: pwdTextBoxController,
            onChanged: (value) =>  {},//userPassword = value,
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

  Widget buildLoginBtn() {
    //print(idTextBoxController.text.toString());
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () async {
          userProvider.login(idTextBoxController.text.toString(), pwdTextBoxController.text.toString())
          .then((value) {
            if(userProvider.getMe()==null){
              showErrorDialog(context,'이메일 혹은 비밀번호를 확인하세요');
            }else{
              Navigator.pushNamed(context, routeHome);
              // Navigator.of(context).pop();
            }
          });
          
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // color: Colors.white,
        color: Color(0xFF0275D8),
        child: Text('로그인',
          style: TextStyle(
            color: Color(0xFFAFD9FE),
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        ),
      ),
    );
  }

  Widget buildCABtn(BuildContext context){
    return FlatButton(
      child: Text('create account'),
      onPressed: (){
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignUpPage()));
      },
    );
  }

  showErrorDialog(BuildContext context,String str){
    showDialog(
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