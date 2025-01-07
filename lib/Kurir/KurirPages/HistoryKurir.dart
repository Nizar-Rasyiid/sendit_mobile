import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sendit/Kurir/KurirPages/HomeKurir.dart';
import 'BottomNavigation.dart';
import 'package:sendit/models/user.dart';
import 'package:http/http.dart' as http;

class HistoryKurir extends StatefulWidget {
  final User user;

  const HistoryKurir({super.key, required this.user});

  @override
  _HistoryKurirState createState() => _HistoryKurirState();
}

class _HistoryKurirState extends State<HistoryKurir> {
  int _currentIndex = 1;
  Future<List<dynamic>>? _futureWorkHistory;

  @override
  void initState() {
    super.initState();
    _futureWorkHistory = fetchOrdersByKurirId();
  }

  Future<List<dynamic>> fetchOrdersByKurirId() async {
    try {
      final url = Uri.parse(
          'http://192.168.1.11:8000/api/pemesanan/pemesanankurir/${widget.user.id_user}');
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body raw: ${response.body}');
      print("id kurirnya adalah ${widget.user.id_user}");

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);
        print('Response body decoded: $responseBody');
        if (responseBody == null) {
          print('Response body is null, returning empty list');
          return [];
        }
        print('Returning response body');
        return responseBody;
      }
      print('Non-200 status code, returning empty list');
      return [];
    } catch (e) {
      print('Detailed error: $e');
      return [];
    }
  }

  // final List<BottomNavigationBarItem> _navItems = const [
  //   BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
  //   BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
  //   BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        automaticallyImplyLeading: false,
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
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.user.nama ?? '',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(width: 4),
                      CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: Text(
                          'Sendit',
                          style: TextStyle(
                            color: Color(0xFF6C63FF),
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
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureWorkHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Terjadi kesalahan',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Coba refresh halaman',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada riwayat pengiriman',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Riwayat pengiriman Anda akan muncul di sini',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
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
                        item['location'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['status'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['date'] ?? '',
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
                            item['price'] ?? '',
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
            );
          }
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   // items: _navItems,
      //   currentIndex: _currentIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
