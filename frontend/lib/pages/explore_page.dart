import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  bool isFavorite = false; // Tracks favorite status

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance

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

  Future<void> checkIfFavorite() async {
    final user = _auth.currentUser;
    if (user == null || quoteText.isEmpty || author.isEmpty) return;

    final favoritesRef =
        _firestore.collection('users').doc(user.uid).collection('favorites');
    final snapshot = await favoritesRef
        .where('quote', isEqualTo: quoteText)
        .where('author', isEqualTo: author)
        .get();

    setState(() {
      isFavorite = snapshot.docs.isNotEmpty;
    });
  }

  void updateQuote() {
    if (quotes.isEmpty) return;
    final randomQuote = quotes[Random().nextInt(quotes.length)];
    setState(() {
      author = randomQuote['author'] ?? 'Unknown';
      quoteText = randomQuote['quote'] ?? 'No quote available';
      isFavorite = false; // Reset favorite status for new quote
    });
    checkIfFavorite(); // Check if this quote is already a favorite
  }

  void changeColor() {
    setState(() {
      currentColor =
          quoteWidgetColorList[Random().nextInt(quoteWidgetColorList.length)];
    });
  }

  Future<void> toggleFavorite() async {
    final user = _auth.currentUser;

    if (user == null) {
      print('User is not authenticated');
      return;
    }

    final favoritesRef =
        _firestore.collection('users').doc(user.uid).collection('favorites');

    try {
      if (isFavorite) {
        // Remove the quote from favorites
        final snapshot = await favoritesRef
            .where('quote', isEqualTo: quoteText)
            .where('author', isEqualTo: author)
            .get();

        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      } else {
        // Add the quote to favorites
        await favoritesRef.add({
          'author': author,
          'quote': quoteText,
          'addedAt': FieldValue.serverTimestamp(),
        });
      }

      // Toggle the favorite state
      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      print('Error updating favorites: $e');
    }
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
        child: Column(
          children: [
            Expanded(
              child: QuoteWidgetLarge(
                widgetColor: currentColor,
                quoteText: quoteText,
                author: author,
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}
