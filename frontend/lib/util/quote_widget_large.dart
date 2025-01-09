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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                quoteText,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 36),
              Text(
                author,
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 36),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border, size: 24),
              ),
            ]));
  }
}
