import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pachage:widgets/quote_widget.dart'; // Create a reusable widget for displaying quotes

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = 'sample_user_id'; // Replace with dynamic user ID from FirebaseAuth

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quode'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('quotes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No quotes available.'));
          }

          final quotes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              final quote = quotes[index];
              return QuoteWidget(
                quoteId: quote.id,
                author: quote['author'],
                htmlBlockquote: quote['html_blockquote'],
                userId: userId,
              );
            },
          );
        },
      ),
    );
  }
}
