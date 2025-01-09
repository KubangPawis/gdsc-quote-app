import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/log_in_page.dart';
import 'package:frontend/pages/sign_up_page.dart';

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
      home: LoginPage(),
    );
  }
}
