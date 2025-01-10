import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuoteWidgetLarge extends StatefulWidget {
  bool isFavorite;
  final Color widgetColor;
  final String quoteText;
  final String author;

  QuoteWidgetLarge(
      {super.key,
      this.isFavorite = false,
      required this.widgetColor,
      required this.quoteText,
      required this.author});

  @override
  State<QuoteWidgetLarge> createState() => _QuoteWidgetLargeState();
}

class _QuoteWidgetLargeState extends State<QuoteWidgetLarge> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> toggleFavorite() async {
    final user = _auth.currentUser;

    if (user == null) {
      print('User is not authenticated');
      return;
    }

    final favoritesRef =
        _firestore.collection('users').doc(user.uid).collection('favorites');

    try {
      if (widget.isFavorite) {
        // Remove the quote from favorites
        final snapshot = await favoritesRef
            .where('quote', isEqualTo: widget.quoteText)
            .where('author', isEqualTo: widget.author)
            .get();

        for (var doc in snapshot.docs) {
          await doc.reference.delete();
        }
      } else {
        // Add the quote to favorites
        await favoritesRef.add({
          'author': widget.author,
          'quote': widget.quoteText,
          'addedAt': FieldValue.serverTimestamp(),
        });
      }

      // Toggle the favorite state
      setState(() {
        widget.isFavorite = !widget.isFavorite;
      });
    } catch (e) {
      print('Error updating favorites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 36),
        decoration: BoxDecoration(
          color: widget.widgetColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Text(
                  widget.quoteText,
                  maxLines: 4,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 36),
              Text(
                widget.author,
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 36),
              IconButton(
                icon: Icon(
                  widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: toggleFavorite,
              ),
            ]));
  }
}
