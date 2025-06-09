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
    fetchHistory();
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

  Future<void> fetchHistory() async {
    try {
      final response = await http.get(
        Uri.parse('${urlPort}api/pemesanan/pemesanankurir/${widget.user.id_user}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _workHistory = data.map((item) {
            return {
              'id': item['id_pemesanan'] ?? '',
              'pickup_location': item['lokasi_jemput'] ?? 'Alamat jemput tidak tersedia',
              'destination': item['lokasi_tujuan'] ?? 'Alamat tujuan tidak tersedia',
              'sender_name': item['nama_pengirim'] ?? 'Nama pengirim tidak tersedia',
              'receiver_name': item['nama_penerima'] ?? 'Nama penerima tidak tersedia',
              'sender_phone': item['no_hp_pengirim'] ?? '',
              'receiver_phone': item['no_hp_penerima'] ?? '',
              'package_type': item['jenis_paket'] ?? 'Paket',
              'weight_category': item['kategori_berat'] ?? '',
              'status': item['status'] ?? 'Status tidak tersedia',
              'date': _formatDate(item['created_at'] ?? ''),
              'price': 'Rp ${_formatPrice(item['total_harga'] ?? 0)}',
              'payment_method': item['metode_pembayaran'] ?? 'Tidak diketahui',
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

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    final priceStr = price.toString();
    final regex = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return priceStr.replaceAllMapped(regex, (Match m) => '${m[1]}.');
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
      case 'delivered':
        return Colors.green;
      case 'dalam perjalanan':
      case 'on delivery':
        return Colors.orange;
      case 'diambil':
      case 'picked up':
        return Colors.blue;
      case 'dibatalkan':
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
      case 'delivered':
        return Icons.check_circle;
      case 'dalam perjalanan':
      case 'on delivery':
        return Icons.local_shipping;
      case 'diambil':
      case 'picked up':
        return Icons.inventory;
      case 'dibatalkan':
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
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
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.history,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Tidak ada riwayat pengiriman',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: fetchHistory,
                          child: ListView.separated(
                            itemCount: _workHistory.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
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
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      // Header dengan status dan tanggal
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(item['status'] ?? 'Unknown'),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              _getStatusIcon(item['status'] ?? 'Unknown'),
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item['status'] ?? 'Status tidak tersedia',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    item['date'] ?? 'Tanggal tidak tersedia',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              item['price'] ?? 'Rp 0',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Detail pengiriman
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            // Informasi pengirim dan penerima
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person_outline,
                                                            size: 16,
                                                            color: Colors.grey[600],
                                                          ),
                                                          const SizedBox(width: 4),
                                                          Text(
                                                            'Pengirim',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey[600],
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                        item['sender_name'] ?? 'Nama pengirim tidak tersedia',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      if ((item['sender_phone'] ?? '').isNotEmpty)
                                        Text(
                                          item['sender_phone'] ?? '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            size: 16,
                                                            color: Colors.grey[600],
                                                          ),
                                                          const SizedBox(width: 4),
                                                          Text(
                                                            'Penerima',
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey[600],
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                        item['receiver_name'] ?? 'Nama penerima tidak tersedia',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      if ((item['receiver_phone'] ?? '').isNotEmpty)
                                        Text(
                                          item['receiver_phone'] ?? '',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16),
                                            // Alamat jemput
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.blue.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.blue.withOpacity(0.3),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Colors.blue[700],
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Alamat Jemput',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.blue[700],
                                                          ),
                                                        ),
                                                        const SizedBox(height: 2),
                                                        Text(
                                                          item['pickup_location'] ?? 'Alamat jemput tidak tersedia',
                                                          style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black87,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            // Alamat tujuan
                                            Container(
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.green.withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: Colors.green.withOpacity(0.3),
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.flag,
                                                    color: Colors.green[700],
                                                    size: 20,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Alamat Tujuan',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.green[700],
                                                          ),
                                                        ),
                                                        const SizedBox(height: 2),
                                                        Text(
                                                          item['destination'] ?? 'Alamat tujuan tidak tersedia',
                                                          style: const TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black87,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            // Detail paket dan pembayaran
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.withOpacity(0.1),
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons.inventory_2_outlined,
                                                          size: 16,
                                                          color: Colors.grey[700],
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          item['package_type'] ?? 'Paket',
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.grey[700],
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.withOpacity(0.1),
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons.scale_outlined,
                                                          size: 16,
                                                          color: Colors.grey[700],
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          (item['weight_category'] ?? '').isNotEmpty 
                                                              ? item['weight_category'] ?? 'Standar' 
                                                              : 'Standar',
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.grey[700],
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.withOpacity(0.1),
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          Icons.payment,
                                                          size: 16,
                                                          color: Colors.grey[700],
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          item['payment_method'] ?? 'Tidak diketahui',
                                                          style: TextStyle(
                                                            fontSize: 11,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.grey[700],
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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
