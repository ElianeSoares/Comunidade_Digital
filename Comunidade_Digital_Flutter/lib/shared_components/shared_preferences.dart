import 'package:shared_preferences/shared_preferences.dart';

getSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs;
}