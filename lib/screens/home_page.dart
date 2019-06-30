import 'package:flutter/material.dart';

import 'settings.dart';
import 'timeline.dart';
import 'profile.dart';
import 'categories_route.dart';
import 'recommendations_list_screen.dart';

import '../widgets/navigation_icon.dart';
import '../widgets/navigation_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navigationIndex = 0;
  PageController _controller;

  List<Widget> _pages = [
    Timeline(),
    RecommendationsListScreen(),
    CategoriesRoute(),
    Settings(),
    Profile()
  ];

  List<BottomNavigationBarItem> _navigationItems = [
    BottomNavigationBarItem(
        icon: NavigationIcon(Icons.timeline),
        title: NavigationText('Timeline')),
    BottomNavigationBarItem(
        icon: NavigationIcon(Icons.people),
        title: NavigationText('Influencers')),
    BottomNavigationBarItem(
      icon: NavigationIcon(Icons.category),
      title: NavigationText('Categories'),
    ),
    BottomNavigationBarItem(
        icon: NavigationIcon(Icons.settings),
        title: NavigationText('Settings')),
    BottomNavigationBarItem(
        icon: NavigationIcon(Icons.person), title: NavigationText('Profile')),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        reverse: false,
        children: _pages,
        onPageChanged: (int index) {
          setState(() {
            _navigationIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navigationItems,
        currentIndex: _navigationIndex,
        onTap: (value) {
          setState(() {
            _navigationIndex = value;
            _controller.jumpToPage(value);
          });
        },
      ),
    );
  }
}
