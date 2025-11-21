import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/spell_model.dart';
import '../services/api_services.dart';

class SearchSpellPage extends StatefulWidget {
  const SearchSpellPage({super.key});

  @override
  State<SearchSpellPage> createState() => _SearchSpellPageState();
}

class _SearchSpellPageState extends State<SearchSpellPage> {
  late Future<List<Spell>> _spellsFuture;
  List<Spell> _allSpells = [];
  List<Spell> _filteredSpells = [];

  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadSpells();
    _searchController.addListener(_filterSpells);
  }

  void _loadSpells() {
    _spellsFuture = _apiService.fetchSpells();

    _spellsFuture.then((spells) {
      setState(() {
        _allSpells = spells;
        _filteredSpells = spells;
      });
    }).catchError((error) {
      if (mounted) {
        if (kDebugMode) {
          print("Error loading spells: $error");
        }
      }
    });
  }

  void _filterSpells() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredSpells = _allSpells.where((spell) {
        return spell.name.toLowerCase().contains(query) ||
            spell.description.toLowerCase().contains(query);
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
        title: const Text("Find Magic Spell"),
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
                labelText: 'Search by name or description...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Spell>>(
              future: _spellsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          "No internet connection.\nCannot load spells.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                if (!snapshot.hasData || _filteredSpells.isEmpty) {
                  if (_allSpells.isNotEmpty && _filteredSpells.isEmpty) {
                    return const Center(child: Text("No spells match your search."));
                  }
                  return const Center(child: Text("No spells found."));
                }

                return ListView.builder(
                  itemCount: _filteredSpells.length,
                  itemBuilder: (context, index) {
                    final spell = _filteredSpells[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFFD4B9ED),
                          child: const Icon(
                            Icons.auto_fix_high,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          spell.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(spell.description),
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