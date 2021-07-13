import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _prefs;

  static Future<SharedPreferences> init() async {
    Set<String> key = _prefs.getKeys();
    print('All stored Keys: ');
    for (String i in key) {
      print('SharedPrefsName:  ' +
          i +
          "\nValue: " +
          _prefs.get(i).toString() +
          '\n\n');
      /*
        Uncomment to delete all Shared PREFS
        RECOMMENT THEM AFTER DEBUGGING
        Consider to turn Firebase off to prevent Database mess
        WARNING ONLY UNCOMMENT NEXT LINE FOR DEBUGGING REASONS
        */
      //_prefs.remove(i);
    }
    return _prefs = await SharedPreferences.getInstance();
  }

  ///Set a SharedPrefs List<String> (Value,Name)
  setSpStrList(
    String spName,
    List<String> value,
  ) {
    _prefs.setStringList(spName, value);
  }

  ///Get a SharedPrefs List<String> (Name)
  List<String> getSpStringList(String spName) {
    return _prefs.getStringList(spName) ?? [];
  }

  ///Add to a SharedPrefs List<String> (Name)
  addSpStringList(String spName, String value) {
    List<String> dummy = _prefs.getStringList(spName) ?? [];
    if (!dummy.contains(value)) {
      print(dummy);
      print(value);
      dummy.add(value);
    }
    _prefs.setStringList(spName, dummy);
  }

  ///Set a SharedPrefs String (Value,Name)
  setSpStr(String spName, String value) {
    _prefs.setString(spName, value);
  }

  ///Get a SharedPrefs String (Name)
  String getSpStr(String spName) {
    return _prefs.getString(spName) ?? '';
  }

  ///Set a SharedPrefs Int (Name,value)
  setSpInt(String spName, int value) {
    _prefs.setInt(spName, value);
  }

  ///Increase a SharedPrefs Int by value(Name,value)
  increaseSpInt(String spName, int value) {
    _prefs.setInt(spName, (getSpInt(spName) + value));
  }

  ///Get a SharedPrefs Int (Name)
  getSpInt(String spName) {
    if (_prefs.getInt(spName) == null) {
      return 0;
    }
    return _prefs.getInt(spName) ?? 0;
  }

  ///Set a SharedPrefs Bool (Name)
  setSpBool(String spName, bool value) {
    _prefs.setBool(spName, value);
  }

  ///Get a SharedPrefs Bool (Name)
  getSpBool(String spName) {
    return _prefs.getBool(spName) ?? false;
  }
}
