import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/util/quote_widget_large.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  Color currentColor = Colors.lightBlueAccent;
  String quoteText = '';
  String author = '';

  List<List<String>> quoteList = [
    [
      'Walt Disney',
      'The way to get started is to quit talking and begin doing.'
    ],
    [
      'Nelson Mandela',
      'The greatest glory in living lies not in never falling, but in rising every time we fall.'
    ],
    [
      'Steve Jobs',
      'The future belongs to those who believe in the beauty of their dreams.'
    ],
  ];

  final List quoteWidgetColorList = [
    Color(0xFFFFE0E0),
    Color(0xFFC4F1E3),
    Color(0xFFDAF8FF),
    Color(0xFFFFF8D1),
    Color(0xFFCA9FED),
    Color(0xFF686CFC),
    Color(0xFFFFBD94),
  ];

  @override
  void initState() {
    super.initState();
    // Set an initial color
    currentColor = quoteWidgetColorList[0];
    updateQuote();
  }

  void updateQuote() {
    setState(() {
      author = quoteList[Random().nextInt(quoteList.length)][0];
      quoteText = quoteList[Random().nextInt(quoteList.length)][1];
    });
  }

  void changeColor() {
    // Randomly pick a new color from the list
    setState(() {
      currentColor =
          quoteWidgetColorList[Random().nextInt(quoteWidgetColorList.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          changeColor();
          updateQuote();
        },
        onHorizontalDragEnd: (details) {
          changeColor();
          updateQuote();
        },
        child: QuoteWidgetLarge(
            widgetColor: currentColor, quoteText: quoteText, author: author),
      ),
    );
  }
}
