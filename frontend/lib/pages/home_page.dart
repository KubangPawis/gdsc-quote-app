import 'package:flutter/material.dart';
import 'package:frontend/util/quote_widget_small.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        centerTitle: false,
        title: Text('QUODE',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout, size: 24))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        items: [
          BottomNavigationBarItem(
              label: 'Home', icon: Icon(Icons.home, size: 24)),
          BottomNavigationBarItem(
              label: 'Profile', icon: Icon(Icons.person, size: 24)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 38),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Text
            Padding(
              padding: EdgeInsets.only(top: 16, bottom: 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello Peter',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('Energize your day with a quote!',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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

                return QuoteWidgetSmall(author: author, quoteText: quoteText);
              },
            )),
          ],
        ),
      ),
    );
  }
}
