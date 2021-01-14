import 'dart:convert';

import 'package:comunidade_digital/pages/home.dart';
import 'package:comunidade_digital/pages/signUp/sign_up.dart';
import 'package:comunidade_digital/shared_components/project_config.dart';
import 'package:flutter/material.dart';
import 'package:comunidade_digital/services/auth.dart';
import 'package:comunidade_digital/services/request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return _loginPage(context);

  }

  Widget _loginPage (BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logo_comunidade_digital.png', fit: BoxFit.cover, width: size.width*0.7,),
              SizedBox(height: 50),
              _signInButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton(BuildContext context) {
    return OutlineButton(
      splashColor: primaryColor,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            postRequest("https://us-central1-comunidade-digital.cloudfunctions.net/user-getUserData",{
              "uid": result.uid
            }).then((response) => {
              if(response.body != ""){
                SharedPreferences.getInstance().then((value) => {
                  value.setString("userData", jsonEncode(response.body))
                }),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyHomePage();
                    },
                  ),
                )
              }else{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpPage(user: result);
                    },
                  ),
                )
              }
            });
          }
        }).catchError((error) => {
          print(error)
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Logar com sua conta Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
