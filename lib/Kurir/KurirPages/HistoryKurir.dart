import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sendit/Kurir/KurirPages/HomeKurir.dart';
import 'BottomNavigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sendit/auth/urlPort.dart';
import 'package:sendit/MapPage.dart';
import 'package:sendit/models/user.dart';

class HistoryKurir extends StatefulWidget {
  final User user;

  const HistoryKurir({super.key, required this.user});

  @override
  _HistoryKurirState createState() => _HistoryKurirState();
}

class _HistoryKurirState extends State<HistoryKurir> {
  int _currentIndex = 1;
  List<Map<String, dynamic>> _workHistory = [];
  bool isLoading = true;
  Future<List<dynamic>>? _futureWorkHistory;

  @override
  void initState() {
    super.initState();
    _futureWorkHistory = fetchOrdersByKurirId();
  }

  Future<List<dynamic>> fetchOrdersByKurirId() async {
    try {
      final url = Uri.parse(
          '${urlPort}api/pemesanan/pemesanankurir/${widget.user.id_user}');
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body raw: ${response.body}');
      print("id kurirnya adalah ${widget.user.id_user}");

      if (response.statusCode == 200) {
        final List<dynamic> responseBody = jsonDecode(response.body);
        print('Response body decoded: $responseBody');
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

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      final response = await http.get(
        Uri.parse('${urlPort}api/pemesanan'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _workHistory = data.map((item) {
            return {
              'location': item['lokasi_tujuan'] ?? 'Lokasi tidak tersedia',
              'status': item['status'] ?? 'Status tidak tersedia',
              'date': _formatDate(item['created_at'] ?? ''),
              'price': 'Rp ${item['total_harga'] ?? '0'}',
              // Assuming you have latitude and longitude in your response
              'latitude': item['latitude'] ?? 0.0, // Replace with actual key
              'longitude': item['longitude'] ?? 0.0, // Replace with actual key
            };
          }).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load history');
      }
    } catch (e) {
      print('Error fetching history: $e');
      setState(() {
        isLoading = false;
      });

      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to load history: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  String _formatDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return 'Invalid date';
    }
  }

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
                'assets/sendit.png',
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
                          color: Colors.white,
                        ),
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
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _workHistory.isEmpty
                      ? const Center(child: Text('Tidak ada riwayat pengiriman'))
                      : RefreshIndicator(
                          onRefresh: fetchHistory,
                          child: ListView.separated(
                            itemCount: _workHistory.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = _workHistory[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MapPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF6C63FF),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   // items: _navItems,
      //   currentIndex: _currentIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}