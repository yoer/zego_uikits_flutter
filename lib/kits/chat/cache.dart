// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class ChatCache {
  String _resourceID = "zego_data_zim";

  String get resourceID => _resourceID;
  set resourceID(String value) {
    _resourceID = value;

    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_cacheResourceIDKey, value);
    });
  }

  Future<void> clear() async {
    _resourceID = "zego_data_zim";

    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_cacheResourceIDKey);
  }

  Future<void> load() async {
    if (_isLoaded) {
      return;
    }
    _isLoaded = true;

    final prefs = await SharedPreferences.getInstance();

    _resourceID = (prefs.getString(_cacheResourceIDKey) ?? "zego_data_zim");
  }

  final String _cacheResourceIDKey = 'cache_chat_i_resource_id';

  bool _isLoaded = false;

  ChatCache._internal();

  factory ChatCache() => _instance;

  static final ChatCache _instance = ChatCache._internal();
}
