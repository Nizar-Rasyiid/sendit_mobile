import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF6C63FF),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/sendit_logo.png', // Make sure to add this asset
              height: 24,
            ),
            SizedBox(width: 8),
            Text(
              'Sendit!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/profile_image.png'), // Add this asset
              radius: 16,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Work History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildHistoryItem(
                  'J. Internasional I, Tanean Sumber...',
                  'Rp15.000',
                  Icons.local_shipping,
                ),
                SizedBox(height: 12),
                _buildHistoryItem(
                  'Jl. Untung Suropati No. 32',
                  'Rp10.100',
                  Icons.local_shipping,
                ),
                // Add more history items as needed
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // History tab is selected
        selectedItemColor: Color(0xFF6C63FF),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String address, String price, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF6C63FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Color(0xFF6C63FF)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
