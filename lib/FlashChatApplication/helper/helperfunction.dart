import 'package:shared_preferences/shared_preferences.dart';
class HelperFunction{
  static const String sharedPrefferenceUserLoggedInKey = "ISLOGGEDIN";
  static const String sharedPrefferenceUserNameKey = "USERNAMEKEY";
  static const String sharedPrefferenceUserEmailKey = "USEREMAILKEY";

  static Future<dynamic> saveUserLoggedInSharedPreference(bool isUserLoggedIn)async{
 SharedPreferences prefs = await SharedPreferences.getInstance();
 return await prefs.setBool(sharedPrefferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<dynamic> saveUserNameSharedPreference(String? userName)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefferenceUserNameKey, userName!);
  }

  static Future<dynamic> saveUserEmailSharedPreference(String? userEmail)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefferenceUserEmailKey, userEmail!);
  }
//getting from Shared Preference
  static Future<dynamic> getUserLoggedInSharedPreference()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPrefferenceUserLoggedInKey);
  }

  static Future<dynamic> getUserNameSharedPreference()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefferenceUserNameKey);
  }

  static Future<dynamic> getUserEmailSharedPreference()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefferenceUserEmailKey);
  }

}