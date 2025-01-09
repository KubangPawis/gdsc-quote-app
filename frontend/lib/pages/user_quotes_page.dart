import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/util/quote_widget_small.dart';

class UserQuotesPage extends StatefulWidget {
  const UserQuotesPage({super.key});

  @override
  State<UserQuotesPage> createState() => _UserQuotesPageState();
}

class _UserQuotesPageState extends State<UserQuotesPage> {
  List<List<String>> quoteList = [
    ['Winston Churchill', 'If you are going through hell, keep going.'],
    ['Winston Churchill', 'If you are going through hell, keep going.'],
    ['Winston Churchill', 'If you are going through hell, keep going.'],
    ['Winston Churchill', 'If you are going through hell, keep going.'],
    ['Winston Churchill', 'If you are going through hell, keep going.'],
    ['Winston Churchill', 'If you are going through hell, keep going.'],
    ['Winston Churchill', 'If you are going through hell, keep going.'],
    ['Winston Churchill', 'If you are going through hell, keep going.'],
    ['Winston Churchill', 'If you are going through hell, keep going.'],
    ['Winston Churchill', 'If you are going through hell, keep going.'],
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

  void deleteQuote(int index) {
    setState(() {
      quoteList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            children: [
              Column(
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
                        Text('Hello, Peter!',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        Text('Energize your day with a quote!',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                  // Quote List
                  Expanded(
                      child: ListView.builder(
                    itemCount: quoteList.length,
                    itemBuilder: (context, index) {
                      // Get key value pairs in map
                      String author = quoteList[index][0];
                      String quoteText = quoteList[index][1];

                      // Get random color
                      var widgetColor = quoteWidgetColorList[
                          Random().nextInt(quoteWidgetColorList.length)];

                      return QuoteWidgetSmall(
                        widgetColor: widgetColor,
                        author: author,
                        quoteText: quoteText,
                        deleteQuote: (context) => deleteQuote(index),
                      );
                    },
                  )),
                ],
              ),

              // >>>>>>>>>>> EXPLORE PAGE
              Center(child: Text('hatdog')),
            ],
          ),
        ),
      ],
    );
  }
}
