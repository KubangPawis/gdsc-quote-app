import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Add Firebase Core
import 'home_page.dart'; // Create this page for the quotes display
import 'favorites_page.dart'; // Create this page for the favorites list

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const Quode());
}

class Quode extends StatelessWidget {
  const Quode({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), // Set the HomePage as the starting point
      routes: {
        '/favorites': (context) => FavoritesPage(), // Add navigation for the Favorites page
      },
    );
  }
}
