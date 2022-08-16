import 'package:flutter/material.dart';
import 'package:loginui/fetch-data-from-api.dart';
import 'package:loginui/fetch-data-hard.dart';
import 'package:loginui/future-builder.dart';
import 'create-employee.dart';
import 'fetch_post_dio.dart';

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
    FetchPostsUsingDio(),
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
                label: 'Fetch Albums Page',
                backgroundColor: Colors.blue,
                icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                label: 'Fetch Employee Page',
                backgroundColor: Colors.blue,
                icon: Icon(Icons.person)),
            BottomNavigationBarItem(
                label: 'Fetch Posts',
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
