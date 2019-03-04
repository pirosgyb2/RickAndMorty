import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/module/characters/character_view.dart';
import 'package:rick_and_morty_app/module/episodes/episode_view.dart';
import 'package:rick_and_morty_app/module/locations/location_view.dart';

class CommonPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CommonPageState();
  }
}

class _CommonPageState extends State<CommonPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CharactersPage(),
    LocationsPage(),
    EpisodesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            title: new Text('Characters'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.location_city),
            title: new Text('Locations'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.local_movies),
            title: new Text('Episodes'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
