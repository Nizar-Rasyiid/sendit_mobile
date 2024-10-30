import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key});

  // Fungsi untuk menampilkan dialog konfirmasi
  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Pembatalan'),
          content: const Text('Apakah anda yakin untuk membatalkan pesanan?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text(
                'Tidak',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                // Kembali ke halaman order
                Navigator.of(context).pushReplacementNamed('/orderPage'); // Ganti dengan nama route yang sesuai
                // Atau gunakan Navigator.pop() jika ingin kembali ke halaman sebelumnya
                // Navigator.of(context).pop();
              },
              child: const Text(
                'Ya',
                style: TextStyle(
                  color: Color(0xFF6C63FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text(
          'Order Tracking',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              // Handle chat action
            },
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTrackingStatus(),
              const SizedBox(height: 20),
              _buildCourierInfo(),
              const SizedBox(height: 20),
              _buildPickupAddress(),
              const SizedBox(height: 20),
              _buildDeliveryAddress(),
              const SizedBox(height: 20),
              _buildTotalWeight(),
              const SizedBox(height: 20),
              _buildPaymentDetails(),
              const SizedBox(height: 30),
              _buildDeliveryStatus(),
              const SizedBox(height: 20),
              _buildCancelButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ... (kode widget lainnya tetap sama)

  Widget _buildCancelButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showCancelConfirmationDialog(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Batalkan Pesanan',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  // ... (sisanya kode tetap sama seperti sebelumnya)
  Widget _buildTrackingStatus() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Menjemput paket dalam 1 menit',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Image.asset(
            'assets/sendit.png',
            height: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryStatus() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildStatusPoint(true, isActive: true),
              _buildStatusLine(true),
              _buildStatusPoint(true, isActive: true),
              _buildStatusLine(false),
              _buildStatusPoint(false, isActive: false),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Dijemput',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C63FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Dikirim',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C63FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Selesai',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusPoint(bool isCompleted, {required bool isActive}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF6C63FF) : Colors.grey.shade300,
        border: Border.all(
          color: isActive ? const Color(0xFF6C63FF) : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: isCompleted
          ? const Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            )
          : null,
    );
  }

  Widget _buildStatusLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? const Color(0xFF6C63FF) : Colors.grey.shade300,
      ),
    );
  }

Widget _buildCourierInfo() {
  return Row(
    children: [
      const CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          'assets/darwin.png',
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Muhammad Irawan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'D 1203 FE',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Row(
              children: [
                const SizedBox(width: 0), // Hapus padding kiri
                IconButton(
                  padding: EdgeInsets.zero, // Hapus padding internal icon button
                  constraints: const BoxConstraints(), // Hapus constraints default
                  icon: const Icon(Icons.chat, color: Color(0xFF6C63FF)),
                  onPressed: () {
                    // Handle chat action
                  },
                ),
                const SizedBox(width: 24),
                IconButton(
                  padding: EdgeInsets.zero, // Hapus padding internal icon button
                  constraints: const BoxConstraints(), // Hapus constraints default
                  icon: const Icon(Icons.phone, color: Color(0xFF6C63FF)),
                  onPressed: () {
                    // Handle call action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

  Widget _buildPickupAddress() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pickup Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Jl. Surya Sumantri BLOK A Nomor 17, Arab, Cicaheum',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
  
  Widget _buildDeliveryAddress() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Jl. Telekomunikasi. 1, Terusan Buahbatu -\nBojongsong, Telkom University, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTotalWeight() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total Weight',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('Max. 5kg'),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildPaymentDetailRow('Trip fare', 'Rp28.000'),
        _buildPaymentDetailRow('Platform fee', 'Rp2.000'),
        _buildPaymentDetailRow('Extra package protection', 'Rp5.000'),
        const Divider(),
        _buildPaymentDetailRow('Total', 'Rp35.000', isTotal: true),
      ],
    );
  }

  Widget _buildPaymentDetailRow(String title, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }
}