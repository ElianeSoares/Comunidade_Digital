import 'package:comunidade_digital/pages/home.dart';
import 'package:comunidade_digital/shared_components/project_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/login.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Comunidade Digital',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<String>(
        future: _isUserLogged(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if(snapshot.hasData)
            return MyHomePage();
          else
            return LoginPage();
        }
      ),
      builder: EasyLoading.init(),
    );
  }

  Future<String> _isUserLogged() async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    return prefs.getString("userData");
  }

}


