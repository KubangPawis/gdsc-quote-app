import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = 'sample_user_id'; // Replace with dynamic user ID from FirebaseAuth

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('favorites')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }

          final favoriteQuotes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: favoriteQuotes.length,
            itemBuilder: (context, index) {
              final quote = favoriteQuotes[index];
              return ListTile(
                title: Text(quote.id), // Use the quote's ID
                subtitle: Text(quote['author'] ?? 'Unknown'),
              );
            },
          );
        },
      ),
    );
  }
}
