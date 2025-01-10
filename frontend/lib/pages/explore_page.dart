import 'dart:math';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import 'package:frontend/util/quote_widget_large.dart';
import 'package:flutter/rendering.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  Color currentColor = Colors.lightBlueAccent;
  String quoteText = '';
  String author = '';
  bool isFavorite = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey globalKey = GlobalKey(); // For RepaintBoundary

  final List quoteWidgetColorList = [
    Color(0xFFFFE0E0),
    Color(0xFFC4F1E3),
    Color(0xFFDAF8FF),
    Color(0xFFFFF8D1),
    Color(0xFFCA9FED),
    Color(0xFF686CFC),
    Color(0xFFFFBD94),
  ];

  List<Map<String, dynamic>> quotes = [];

  @override
  void initState() {
    super.initState();
    currentColor =
        quoteWidgetColorList[Random().nextInt(quoteWidgetColorList.length)];
    fetchQuotes();
  }

  Future<void> fetchQuotes() async {
    try {
      final snapshot = await _firestore.collection('quotes').get();
      setState(() {
        quotes = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        if (quotes.isNotEmpty) {
          updateQuote();
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
      isFavorite = false;
    });
    checkIfFavorite();
  }

  void changeColor() {
    setState(() {
      currentColor =
          quoteWidgetColorList[Random().nextInt(quoteWidgetColorList.length)];
    });
  }

  Future<void> saveQuoteAsImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 2.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        final buffer = byteData.buffer;
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/quote_${DateTime.now().millisecondsSinceEpoch}.png';
        File file = File(filePath);
        await file.writeAsBytes(buffer.asUint8List());
        print('Image saved at $filePath');
      }
    } catch (e) {
      print('Error saving image: $e');
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
        child: RepaintBoundary(
          key: globalKey,
          child: Column(
            children: [
              Expanded(
                child: QuoteWidgetLarge(
                  isFavorite: isFavorite,
                  widgetColor: currentColor,
                  quoteText: quoteText,
                  author: author,
                  onDownloadPressed: saveQuoteAsImage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
