import 'package:flutter/material.dart';
import 'package:loginui/fetch-data-from-api.dart';
import 'package:loginui/fetch-data-hard.dart';
import 'package:loginui/future-builder.dart';
import 'package:http/http.dart' as http;
import 'create-employee.dart';

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
    EmployeeDataFetch(),
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
          title: const Text('Home'),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreateEmployeeForm()));
          },
          backgroundColor: Colors.blueGrey,
          child: const Icon(Icons.add),
        ),
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)));
  }
}
