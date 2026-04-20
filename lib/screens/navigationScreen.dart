import 'package:flutter/material.dart';
import 'package:mangaku/screens/homeScreen.dart';
import 'package:mangaku/screens/searchScreen.dart';
import 'package:mangaku/screens/libraryScreen.dart';
import 'package:mangaku/screens/activityScreen.dart';
import 'package:mangaku/widgets/BottomNavBar.dart';

class NavigationScreen extends StatefulWidget {
  static const routename = "/navigation-screen";

  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Searchscreen(),
    const LibraryScreen(),
    const ActivityScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
