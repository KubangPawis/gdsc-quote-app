import 'package:flutter/material.dart';
import 'package:frontend/pages/home_staging_page.dart';
import 'package:frontend/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentPageIndex = 0;
  late TabController _tabController;
  bool _isBottomNavVisible = true;

  final List _pages = [
    HomeStagingPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _isBottomNavVisible = _tabController.index != 1;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/login'),
                  icon: Icon(Icons.logout, color: Colors.black87, size: 24)),
            )
          ],
        ),

        // BOTTOM NAVIGATION BAR
        bottomNavigationBar: _isBottomNavVisible
            ? Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(255, 144, 173, 199), width: 2),
                  ),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentPageIndex,
                  onTap: _navigateBottomBar,
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
              )
            : null,

        //BODY
        body: _pages[_currentPageIndex],
      ),
    );
  }
}
