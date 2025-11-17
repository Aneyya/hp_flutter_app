import 'package:flutter/material.dart';
import '../models/character_model.dart';

class CharacterDetailPage extends StatelessWidget {
  final Character character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    const mediumPurple = Color(0xFF5A26B1);
    const lightgold = Color(0xFFC38524);

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
        backgroundColor: mediumPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: lightgold, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: character.image.isNotEmpty
                        ? NetworkImage(character.image)
                        : null,
                    child: character.image.isEmpty
                        ? Icon(
                      Icons.person_outline,
                      size: 100,
                      color: Colors.grey.shade600,
                    )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                character.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        icon: Icons.account_balance,
                        title: "House",
                        value: character.house.isNotEmpty ? character.house : "N/A",
                        iconColor: mediumPurple,
                      ),
                      _buildDetailRow(
                        icon: Icons.category,
                        title: "Species",
                        value: character.species.isNotEmpty ? character.species : "N/V",
                        iconColor: mediumPurple,
                      ),
                      _buildDetailRow(
                        icon: Icons.person_search,
                        title: "Played by",
                        value: character.actor.isNotEmpty ? character.actor : "N/A",
                        iconColor: mediumPurple,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    Color iconColor = Colors.grey,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}