import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:frontend/util/quote_widget_small.dart';

class UserQuotesPage extends StatefulWidget {
  const UserQuotesPage({super.key});

  @override
  State<UserQuotesPage> createState() => _UserQuotesPageState();
}

class _UserQuotesPageState extends State<UserQuotesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance; // For current user

  final List<Color> quoteWidgetColorList = [
    Color(0xFFFFE0E0),
    Color(0xFFC4F1E3),
    Color(0xFFDAF8FF),
    Color(0xFFFFF8D1),
    Color(0xFFCA9FED),
    Color(0xFF686CFC),
    Color(0xFFFFBD94),
  ];

  List<Map<String, dynamic>> favoriteQuotes = []; // Holds user's favorite quotes

  @override
  void initState() {
    super.initState();
    fetchFavoriteQuotes();
  }

  // Fetch user's favorite quotes from Firestore
  Future<void> fetchFavoriteQuotes() async {
    try {
      final user = _auth.currentUser; // Get the current logged-in user
      if (user == null) {
        print("No user is logged in.");
        return;
      }

      final snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .orderBy('addedAt', descending: true)
          .get();

      setState(() {
        favoriteQuotes =
            snapshot.docs.map((doc) => {...doc.data(), 'id': doc.id}).toList();
      });
    } catch (e) {
      print('Error fetching favorite quotes: $e');
    }
  }

  // Delete a favorite quote from Firestore and the UI
  Future<void> deleteFavoriteQuote(String quoteId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) return;

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(quoteId)
          .delete();

      setState(() {
        favoriteQuotes.removeWhere((quote) => quote['id'] == quoteId);
      });
    } catch (e) {
      print('Error deleting favorite quote: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Greeting Text
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${_auth.currentUser?.displayName ?? 'Guest'}!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                'Energize your day with a quote!',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        // Quote List
        Expanded(
          child: favoriteQuotes.isEmpty
              ? Center(
                  child: Text(
                    'No favorite quotes yet. Start exploring and add some!',
                    style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteQuotes.length,
                  itemBuilder: (context, index) {
                    final quote = favoriteQuotes[index];
                    final author = quote['author'] ?? 'Unknown';
                    final quoteText = quote['quote'] ?? 'No quote available';

                    // Get random color
                    final widgetColor = quoteWidgetColorList[
                        Random().nextInt(quoteWidgetColorList.length)];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: QuoteWidgetSmall(
                        widgetColor: widgetColor,
                        author: author,
                        quoteText: quoteText,
                        deleteQuote: (context) =>
                            deleteFavoriteQuote(quote['id']),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
