import 'package:flutter/material.dart';
import 'package:frontend/pages/explore_page.dart';
import 'package:frontend/pages/user_quotes_page.dart';

class HomeStagingPage extends StatefulWidget {
  const HomeStagingPage({super.key});

  @override
  State<HomeStagingPage> createState() => _HomeStagingPageState();
}

class _HomeStagingPageState extends State<HomeStagingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            children: [
              // >>>>>>>>>>> YOUR QUOTES PAGE
              UserQuotesPage(),

              // >>>>>>>>>>> EXPLORE PAGE
              ExplorePage(),
            ],
          ),
        ),
      ],
    );
  }
}
