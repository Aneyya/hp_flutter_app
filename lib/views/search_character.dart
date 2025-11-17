import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/character_model.dart';
import '../services/api_services.dart';
import 'character_detail.dart';

class SearchCharacterPage extends StatefulWidget {
  const SearchCharacterPage({super.key});

  @override
  State<SearchCharacterPage> createState() => _SearchCharacterPageState();
}

class _SearchCharacterPageState extends State<SearchCharacterPage> {
  late Future<List<Character>> _charactersFuture;
  List<Character> _allCharacters = [];
  List<Character> _filteredCharacters = [];

  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadCharacters();
    _searchController.addListener(_filterCharacters);
  }

  void _loadCharacters() {
    _charactersFuture = _apiService.fetchCharacters();

    _charactersFuture.then((characters) {
      setState(() {
        _allCharacters = characters;
        _filteredCharacters = characters;
      });
    }).catchError((error) {
      if (kDebugMode) {
        print("Error loading characters: $error");
      }
    });
  }

  void _filterCharacters() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCharacters = _allCharacters.where((character) {
        return character.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const mediumPurple = Color(0xFF5A26B1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Character"),
        backgroundColor: mediumPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Character>>(
              future: _charactersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || _filteredCharacters.isEmpty) {
                  if (_allCharacters.isNotEmpty && _filteredCharacters.isEmpty) {
                    return const Center(child: Text("No characters match your search."));
                  }
                  return const Center(child: Text("No characters found."));
                }

                return ListView.builder(
                  itemCount: _filteredCharacters.length,
                  itemBuilder: (context, index) {
                    final character = _filteredCharacters[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: character.image.isNotEmpty
                              ? NetworkImage(character.image)
                              : null,
                          child: character.image.isEmpty
                              ? const Icon(Icons.person, color: Colors.grey)
                              : null,
                        ),
                        title: Text(
                          character.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(character.house.isNotEmpty ? character.house : 'No House'),
                        trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CharacterDetailPage(character: character),
                              ),
                            );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}