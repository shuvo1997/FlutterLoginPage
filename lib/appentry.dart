import 'package:flutter/material.dart';
import 'package:loginui/fetch-data-from-api.dart';
import 'package:loginui/future-builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyFutureBuilderTest(),
    AlbumFetchExample(),
    Text(
      'Profile Page',
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                label: 'Home Page',
                backgroundColor: Colors.blue,
                icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Search Page',
                backgroundColor: Colors.blue,
                icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                label: 'Profile Page',
                backgroundColor: Colors.blue,
                icon: Icon(Icons.person)),
          ],
          showUnselectedLabels: true,
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5,
        ),
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)));
  }
}
