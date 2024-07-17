import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  Future<void> saveData(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getData(String key) {
    return _prefs.getString(key);
  }
}
