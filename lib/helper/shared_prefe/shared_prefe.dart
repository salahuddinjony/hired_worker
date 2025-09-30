// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharePrefsHelper {
  //===========================Get Data From Shared Preference===================

  static Future<String> getString(String key,{String defaultValue = ''}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? defaultValue;
  }



  static Future<List<String>> getLisOfString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var getListData = preferences.getStringList(key);

    return getListData!;
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    return preferences.getBool(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

///===========================Save Data To Shared Preference===================

  static Future<void> setString(String key, String? value) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // await preferences.setString(key, value!);
    if (value != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } else {
      debugPrint("Warning: Trying to set a null value for key: $key");
    }
  }
/*  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }*/

/*  static Future<void> setString(String key, String? value) async {
   // SharedPreferences preferences = await SharedPreferences.getInstance();
   // await preferences.setString(key, value!);
    if (value != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } else {
      print("Warning: Trying to set a null value for key: $key");
    }
  }*/

  static Future<bool> setListOfString(String key, List<String> value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var setListData = await preferences.setStringList(key, value);

    return setListData;
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }

//===========================Remove Value===================

  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }


  ///========Save String Value =======
  // Save a string value
  static Future<void> saveData(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  // Save String value
  static Future<void> saveString(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }
/*  // Get a string value
  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }*/

}


