import 'package:flutter/material.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order List',
          style: TextStyle(
            color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6C63FF),
        iconTheme: const IconThemeData(
          color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return OrderItem();
        },
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF6C63FF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Jl. Contoh Alamat No. 1',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold, 
              color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Jl. Contoh Alamat No. 2',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'Harga: Rp 100.000',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Logika untuk menerima pesanan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pesanan diterima')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 66, 72, 255),
                ),
                child: const Text('Terima'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Logika untuk menolak pesanan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pesanan ditolak')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Tolak'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
