import 'package:flutter/material.dart';
import 'package:sendit/payment/paymentPage.dart'; // Pastikan untuk mengimpor PaymentPage

class OrderInformationPage extends StatelessWidget {
  const OrderInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/sendit.png', // Pastikan untuk menambahkan aset ini
              height: 24,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            const Text(
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
          CircleAvatar(
            backgroundImage: AssetImage('assets/profile_picture.png'), // Tambahkan aset ini
            radius: 16,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Informasi Pengirim
              const Text(
                'Informasi Pengirim',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildInputField('Nama Pengirim'),
              const SizedBox(height: 16),
              _buildInputField('Nomor Pengirim'),
              const SizedBox(height: 24),
              _buildInputField('Informasi Tambahan', maxLines: 3), // Informasi tambahan untuk pengirim
              const SizedBox(height: 24),

              // Informasi Penerima
              const Text(
                'Informasi Penerima',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildInputField('Nama Penerima'),
              const SizedBox(height: 16),
              _buildInputField('Nomor Penerima'),
              const SizedBox(height: 16),
              _buildInputField('Informasi Tambahan', maxLines: 3), // Informasi tambahan hanya untuk penerima
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman PaymentPage ketika tombol ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PaymentPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Lanjutkan', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF6C63FF),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Tracking'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, {int maxLines = 1}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
