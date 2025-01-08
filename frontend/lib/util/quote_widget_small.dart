import 'package:flutter/material.dart';

class QuoteWidgetSmall extends StatelessWidget {
  final String quoteText;
  final String author;

  const QuoteWidgetSmall(
      {super.key, required this.quoteText, required this.author});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 143, 135),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Text(quoteText, style: TextStyle(fontSize: 12)),
          SizedBox(height: 3),
          Text(author, style: TextStyle(fontSize: 11)),
        ]),
      ),
    );
  }
}
