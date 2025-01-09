import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List quoteWidgetColorList = [
    Color(0xFFFFE0E0),
    Color(0xFFC4F1E3),
    Color(0xFFDAF8FF),
    Color(0xFFFFF8D1),
    Color(0xFFCA9FED),
    Color(0xFF686CFC),
    Color(0xFFFFBD94),
  ];

  List<Map<String, dynamic>> quotes = []; // Holds quotes from Firestore

  @override
  void initState() {
    super.initState();
    fetchQuotes();
  }

  // Fetch all quotes from Firestore
  Future<void> fetchQuotes() async {
    try {
      final snapshot = await _firestore.collection('quotes').get();
      setState(() {
        quotes = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        if (quotes.isNotEmpty) {
          updateQuote(); // Initialize the first quote
        }
      });
    } catch (e) {
      print('Error fetching quotes: $e');
    }
  }

  void updateQuote() {
    if (quotes.isEmpty) return;
    final randomQuote = quotes[Random().nextInt(quotes.length)];
    setState(() {
      author = randomQuote['author'] ?? 'Unknown';
      quoteText = randomQuote['quote'] ?? 'No quote available';
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
