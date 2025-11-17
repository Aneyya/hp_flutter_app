import 'package:flutter/material.dart';

import 'views/home_page.dart';


void main() => runApp(const SimpleMagicApp());
class SimpleMagicApp extends StatelessWidget {
  const SimpleMagicApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F4FA),
      ),
    );
  }
}
