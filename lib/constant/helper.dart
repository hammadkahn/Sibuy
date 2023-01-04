import 'package:shared_preferences/shared_preferences.dart';

class AppHelper {

  static setPref(key, val) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(key, val);
  }

  static getPref(key) async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(key);
  }

  static removePref(key) async {
    var pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }
}