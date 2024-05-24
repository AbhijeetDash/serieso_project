import 'package:shared_preferences/shared_preferences.dart';

abstract class SeoSharedPrefsService {
  void savePageArguments(String key, Map<String, dynamic> arguments);

  Future<Map<String, dynamic>> getPageArguments(String key);
}

class SeoSharedPrefsServiceImpl extends SeoSharedPrefsService {
  @override
  Future<Map<String, dynamic>> getPageArguments(String key) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return {};
  }

  @override
  void savePageArguments(String key, Map<String, dynamic> arguments) async {
// Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
