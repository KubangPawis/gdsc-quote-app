import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/log_in_page.dart';
import 'package:frontend/pages/sign_up_page.dart';
import 'package:frontend/pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const Quode());
}

class Quode extends StatelessWidget {
  const Quode({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quode',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Set the initial route to LoginPage
      routes: {
        '/login': (context) => LoginPage(), // Login page route
        '/signup': (context) => SignUpPage(), // Sign-up page route
        '/home': (context) => HomePage() // Homepage
      },
    );
  }
}
