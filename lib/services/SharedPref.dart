import 'package:shared_preferences/shared_preferences.dart';

class SharedPref{
  static final SharedPref instance = SharedPref._internal();

  factory SharedPref() => instance;

  SharedPref._internal();

  SharedPreferences? prefs;

  dynamic getValue(String value){
    return prefs!.get(value);
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

  }

  void setValue(String key, dynamic value) {
    if(value is String){
      prefs!.setString(key, value);
    }else if(value is int){
      prefs!.setInt(key, value);
    }else if(value is double){
      prefs!.setDouble(key, value);
    }else if(value is bool){
      prefs!.setBool(key, value);
    }else if(value is List<String>){
      prefs!.setStringList(key, value);
    }
  }


}