import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/character_model.dart';
import '../services/api_services.dart';
import '../services/local_storage_service.dart';
import 'character_detail.dart';

class SearchCharacterPage extends StatefulWidget {
  const SearchCharacterPage({super.key});

  @override
  State<SearchCharacterPage> createState() => _SearchCharacterPageState();
}

class _SearchCharacterPageState extends State<SearchCharacterPage> {
  final ApiService _apiService = ApiService();
  final LocalStorageService _storageService = LocalStorageService();

  final TextEditingController _searchController = TextEditingController();


  List<Character> _allCharacters = [];
  List<Character> _filteredCharacters = [];
  bool _isOfflineMode = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
    }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final characters = await _apiService.fetchCharacters();

      setState(() {
        _allCharacters = characters;
        _filteredCharacters = characters;
        _isOfflineMode = false;
        _isLoading = false;
      });

      await _storageService.saveCharacters(characters);

    } catch (e) {
      if (kDebugMode) print("Błąd sieci: $e. Próba wczytania z serwisu lokalnego...");

      final cachedCharacters = await _storageService.getCachedCharacters();

      if (cachedCharacters.isNotEmpty) {
        setState(() {
          _allCharacters = cachedCharacters;
          _filteredCharacters = cachedCharacters;
          _isOfflineMode = true;
          _isLoading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No internet. Showing offline data.')),
          );
        }
      }
    }
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCharacters = _allCharacters;
      } else {
        _filteredCharacters = _allCharacters.where((c){
          return c.name.toLowerCase().contains(query);
        }).toList();
      }
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
        actions: [
          if (_isOfflineMode)
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.wifi_off, color: Colors.white70),
            )
        ],
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
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredCharacters.isEmpty
                  ? const Center(child: Text("No characters found."))
                  : ListView.builder(
                      itemCount: _filteredCharacters.length,
                      itemBuilder: (context, index) {
                        final character = _filteredCharacters[index];
                        final bool shouldShowImage = character.image.isNotEmpty && !_isOfflineMode;

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
                              backgroundImage: shouldShowImage
                                  ? NetworkImage(character.image)
                                  : null,
                              child: !shouldShowImage
                                  ? const Icon(Icons.person)
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
                                builder: (_) => CharacterDetailPage(character: character, isOfflinemode: _isOfflineMode),
                                ),
                              );
                            },
                          ),
                        );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}