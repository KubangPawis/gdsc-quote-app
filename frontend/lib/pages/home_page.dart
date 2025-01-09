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

  void deleteQuote(int index) {
    setState(() {
      quoteList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //backgroundColor: Colors.white,
          toolbarHeight: 80,
          centerTitle: false,
          bottom: TabBar(tabs: [
            Tab(text: 'Your Quotes'),
            Tab(text: 'Explore'),
          ]),
          title: Text('QUODE',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.logout, size: 24))
          ],
        ),

        // BOTTOM NAVIGATION BAR
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: Color.fromARGB(255, 144, 173, 199), width: 2),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentPageIndex,
            onTap: (value) {},
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                  label: 'Home', icon: Icon(Icons.home, size: 24)),
              BottomNavigationBarItem(
                  label: 'Profile', icon: Icon(Icons.person, size: 24)),
            ],
          ),
        ),

        //BODY
        body: Column(
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
                        padding: EdgeInsets.only(top: 16, bottom: 48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hello Peter',
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

                          return QuoteWidgetSmall(
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
        ),
      ),
    );
  }
}
