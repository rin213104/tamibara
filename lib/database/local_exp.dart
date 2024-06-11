import 'package:shared_preferences/shared_preferences.dart';

class ExperienceStorage {
  static const String _key = 'exp';

  Future<void> saveExperience(double experience) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_key, experience);
  }

  Future<double> getExperience() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_key) ?? 0.0;
  }
}
