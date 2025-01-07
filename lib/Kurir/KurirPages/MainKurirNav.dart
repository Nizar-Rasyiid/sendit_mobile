import 'package:flutter/material.dart';
import 'HistoryKurir.dart';
import 'ProfileKurir.dart'; // You'll need to create this file
import 'HomeKurir.dart'; // You'll need to create this file
import 'package:sendit/models/user.dart';

class MainKurirNavigation extends StatefulWidget {
  final User user;
  final String token;

  const MainKurirNavigation({
    Key? key,
    required this.user,
    required this.token,
  }) : super(key: key);

  @override
  _MainKurirNavigationState createState() => _MainKurirNavigationState();
}

class _MainKurirNavigationState extends State<MainKurirNavigation> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeKurir(user: widget.user),
      HistoryKurir(user: widget.user),
      ProfileKurir(user: widget.user),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF6C63FD),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
