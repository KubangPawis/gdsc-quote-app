import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(12),
        child: Container(
            child: Column(
          children: [
            Text(
              'It is what is it.',
            ),
            Text(
              'Sun Tzu',
            ),
          ],
        )));
  }
}
