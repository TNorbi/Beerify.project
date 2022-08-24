import 'package:beerify/screens/bottom_navigation_bar_screens/gallery_screen.dart';
import 'package:beerify/screens/bottom_navigation_bar_screens/home_screen.dart';
import 'package:beerify/screens/bottom_navigation_bar_screens/profile_screen.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  String _title = 'Home Screen';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_title),
          ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              HomeScreen(),
              GalleryScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget menu() {
  return Container(
    color: Colors.green,
    child: TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorColor: Colors.tealAccent,
      tabs: [
        Tab(
          text: "Home",
          icon: Icon(Icons.home),
        ),
        Tab(
          text: "Gallery",
          icon: Icon(Icons.account_circle_sharp),
        ),
        Tab(
          text: "Profile",
          icon: Icon(Icons.preview),
        ),
      ],
    ),
  );
}
