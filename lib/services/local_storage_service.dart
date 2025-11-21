import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character_model.dart';
import '../models/spell_model.dart';


class LocalStorageService {

  Future<void> saveCharacters(List<Character> characters) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(
      characters.map((c) => c.toJson()).toList(),
    );
    await prefs.setString('cached_characters', encodedData);
  }

  Future<List<Character>> getCachedCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cachedData = prefs.getString('cached_characters');

    if (cachedData != null) {
      final List<dynamic> decodedList = jsonDecode(cachedData);
      return decodedList.map((item) => Character.fromJson(item)).toList();
    }
    return [];
  }
}