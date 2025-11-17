import 'package:flutter/material.dart';
import 'search_character.dart';
import 'search_spell.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override

  Widget build(BuildContext context) {
    const lightPurple = Color(0xFFD4B9ED);
    const mediumPurple = Color(0xFF5A26B1);
    const lightgold = Color(0xFFC38524);
    const darkgold = Color(0xFFB17106);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightPurple,
                border: Border.all(color: darkgold, width: 3),
              ),

              child: const Icon(
                Icons.auto_fix_high,
                size: 70,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "Harry Potter App",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              "Magic spells and characters",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 80),
            SizedBox(
              width: 240,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchSpellPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: lightgold, width: 3),
                  backgroundColor: mediumPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Find magic spell",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 240,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchCharacterPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  side: BorderSide(color: lightgold, width: 3),
                  backgroundColor: mediumPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Find character",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}