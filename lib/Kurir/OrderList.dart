import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OrderListPage extends StatelessWidget {
  OrderListPage({super.key});

  final List<Map<String, String>> orders = [
    {
      'jemput': 'Jl. Telekomunikasi 1',
      'antar': 'Jl. BuahBakar',
      'tarif': 'Rp.35.000',
      'jarak': '10 km',
    },
    {
      'jemput': 'Jl. Contoh Alamat No. 3',
      'antar': 'Jl. Contoh Alamat No. 4',
      'tarif': 'Rp.150.000',
      'jarak': '15 km',
    },
    {
      'jemput': 'Jl. Contoh Alamat No. 5 nwadnwndanndwndawndwa',
      'antar': 'Jl. Contoh Alamat No. 6',
      'tarif': 'Rp.200.000',
      'jarak': '20 km',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order List',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderItem(order: orders[index]);
        },
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final Map<String, String> order;

  const OrderItem({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PhosphorIcon(
                PhosphorIconsDuotone.truck,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(width: 10), 
              Expanded(
                child: Text(
                  order['jemput'] ?? 'Alamat tidak tersedia',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10), 
              Text(
                order['jarak'] ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              PhosphorIcon(
                PhosphorIconsDuotone.package,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(width: 10), 
              Expanded(
                child: Text(
                  order['antar'] ?? 'Alamat tidak tersedia',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Tarif: ${order['tarif'] ?? 'Tidak tersedia'}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pesanan ditolak')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Tolak',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Pesanan diterima')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C63FF),
                    side: const BorderSide(color: Color(0xFF6C63FF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Terima',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
