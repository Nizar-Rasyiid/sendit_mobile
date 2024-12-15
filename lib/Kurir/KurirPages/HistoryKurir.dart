import 'package:flutter/material.dart';
import 'package:sendit/Kurir/KurirPages/HomeKurir.dart';
import 'BottomNavigation.dart';

class HistoryKurir extends StatefulWidget {
  const HistoryKurir({super.key});

  @override
  _HistoryKurirState createState() => _HistoryKurirState();
}

class _HistoryKurirState extends State<HistoryKurir> {
  int _currentIndex = 1;

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
    BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Map<String, String>> _workHistory = [
    {
      'location': 'J.l Telakuning 1, Tanjung Buah Hulu, Teluk Nibung',
      'status': 'Delivered',
      'date': '04/10/2023',
      'price': 'Rp 60.000',
    },
    {
      'location': 'J.l Merdeka 10, Kebon Jeruk, Jakarta Barat',
      'status': 'Pending',
      'date': '05/10/2023',
      'price': 'Rp 45.000',
    },
    {
      'location': 'J.l Sudirman 15, Karet Tengsin, Jakarta Pusat',
      'status': 'Delivered',
      'date': '05/10/2023',
      'price': 'Rp 55.000',
    },
    {
      'location': 'J.l Gatot Subroto 20, Semanggi, Jakarta Selatan',
      'status': 'Cancelled',
      'date': '05/10/2023',
      'price': 'Rp 0',
    },
    {
      'location': 'J.l Thamrin 25, Menteng, Jakarta Pusat',
      'status': 'Delivered',
      'date': '06/10/2023',
      'price': 'Rp 75.000',
    },
    {
      'location': 'J.l MH Thamrin 30, Gondangdia, Jakarta Pusat',
      'status': 'Pending',
      'date': '06/10/2023',
      'price': 'Rp 65.000',
    },

    // Add more entries as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/sendit.png', // Make sure to add this asset
                height: 24,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors
                        .transparent, // White background for the profile circle
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Muhammad',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white // Purple color for the text
                            ),
                      ),
                      SizedBox(width: 4),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor:
                            Colors.white, // Purple background for the initial
                        child: Text(
                          'M',
                          style: TextStyle(
                            color: Color(
                                0xFF6C63FF), // White color for the initial
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: const [
          // TextButton(
          //   onPressed: () {
          //     // Handle profile editing
          //   },
          //   child: const Text(
          //     'Profile',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Riwayat Pengiriman',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Purple color for the text
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: _workHistory.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = _workHistory[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['location']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['status']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['date']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              item['price']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
