import 'package:flutter/material.dart';
import 'package:frontend/pages/log_in_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/services/auth_services.dart'; // Your auth service file


void main() async {
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
      home: LoginPage(),
    );
  }
}
