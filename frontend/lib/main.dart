import 'package:flutter/material.dart';
import 'package:frontend/pages/sign_up_page.dart';

void main() {
  runApp(const Quode());
}

class Quode extends StatelessWidget {
  const Quode({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quode',
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }
}
