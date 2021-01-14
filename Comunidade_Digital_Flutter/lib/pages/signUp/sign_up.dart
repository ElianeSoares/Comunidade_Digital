import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:comunidade_digital/pages/signUp/body.dart';

class SignUpPage extends StatelessWidget {

  final User user;

  SignUpPage({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user: user)
    );
  }

}