import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UUIDHelper {
  static Future<String> getUUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uuid = prefs.getString('uuid');

    if (uuid == null) {
      uuid = Uuid().v4();
      await prefs.setString('uuid', uuid);
    }

    return uuid;
  }
}
