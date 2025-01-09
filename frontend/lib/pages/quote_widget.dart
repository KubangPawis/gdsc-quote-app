import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteWidget extends StatelessWidget {
  final String quoteId;
  final String author;
  final String htmlBlockquote;
  final String userId;

  QuoteWidget({
    required this.quoteId,
    required this.author,
    required this.htmlBlockquote,
    required this.userId,
  });

  final _firestore = FirebaseFirestore.instance;

  Future<void> toggleFavorite() async {
    final favoritesRef = _firestore.collection('users').doc(userId).collection('favorites');
    final favoriteDoc = favoritesRef.doc(quoteId);

    final docSnapshot = await favoriteDoc.get();
    if (docSnapshot.exists) {
      await favoriteDoc.delete();
    } else {
      await favoriteDoc.set({'author': author, 'htmlBlockquote': htmlBlockquote});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(author),
      subtitle: Text(htmlBlockquote),
      trailing: StreamBuilder<DocumentSnapshot>(
        stream: _firestore
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .doc(quoteId)
            .snapshots(),
        builder: (context, snapshot) {
          final isFavorite = snapshot.data?.exists ?? false;
          return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: toggleFavorite,
          );
        },
      ),
    );
  }
}
