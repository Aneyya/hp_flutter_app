import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';
import '../models/spell_model.dart';

class ApiService {
  static const String _baseUrl = 'https://hp-api.onrender.com/api';

  Future<List<Character>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$_baseUrl/characters'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Character> characters = body
          .map(
            (dynamic item) => Character.fromJson(item),
      )
          .toList();
      return characters;
    } else {
      throw Exception('Failed to load characters from API');
    }
  }

  Future<List<Spell>> fetchSpells() async {
    final response = await http.get(Uri.parse('$_baseUrl/spells'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Spell> spells = body
          .map(
            (dynamic item) => Spell.fromJson(item),
      )
          .toList();

      return spells;
    } else {
      throw Exception('Failed to load spells from API');
    }
  }
}