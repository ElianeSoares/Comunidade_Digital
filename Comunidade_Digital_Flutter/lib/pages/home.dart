import 'dart:convert';

import 'package:comunidade_digital/shared_components/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) => {
      value.setString("userData", null)
    });
    return Scaffold(
        appBar: AppBar(
          title: Text("Comunidade Digital"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bem Vindo ao App Comunidade Digital'
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(),
    );
  }
}