import 'package:flutter/material.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            _buildCancelButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCourierInfo() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            'assets/darwin.png', // Ganti dengan URL gambar profil kurir
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Muhammad Irawan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Text(
              'D 1203 FE',
              style: TextStyle(fontSize: 14, color: Colors.grey), // Keterangan kurir dan plat nomor
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle chat action
                  },
                  label: const Text('Chat', style: TextStyle(fontSize: 14, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.phone, color: Color(0xFF6C63FF)),
                  onPressed: () {
                    // Handle call action
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildPickupAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pickup Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Jl. Surya Sumantri BLOK A Nomor 17, Arab, Cicaheum',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
  
  Widget _buildDeliveryAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Jl. Telekomunikasi. 1, Terusan Buahbatu -\nBojongsong, Telkom University, Sukapura, Kec. Dayeuhkolot, Kabupaten Bandung, Jawa Barat 40257',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildTotalWeight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
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

  Widget _buildCancelButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Handle cancel action
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: const Text('Batalkan Pesanan', style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
