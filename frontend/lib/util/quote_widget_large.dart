import 'package:flutter/material.dart';

class QuoteWidgetLarge extends StatelessWidget {
  final Color widgetColor;
  final String quoteText;
  final String author;

  const QuoteWidgetLarge(
      {super.key,
      required this.widgetColor,
      required this.quoteText,
      required this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 36),
        decoration: BoxDecoration(
          color: widgetColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                quoteText,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 36),
              Text(
                author,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ]));
  }
}
