import 'package:flutter/material.dart';
import 'package:sendit/models/user.dart';
import 'package:sendit/order/orderPage.dart';

class WeightCategoryPage extends StatelessWidget {
  final User? user;
  final String? token;

  const WeightCategoryPage({super.key, this.user, this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pilih Kategori Berat Barang',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Ringan Category
              _buildCategoryCard(
                context: context,
                title: 'Ringan (<20kg)',
                icon: Icons.light_mode,
                color: const Color(0xFF6C63FF),
                description: 'Untuk barang ringan seperti dokumen, pakaian, dll',
                weight: 'Ringan (<20kg)',
              ),
              const SizedBox(height: 24),
              // Berat Category
              _buildCategoryCard(
                context: context,
                title: 'Berat (>20kg)',
                icon: Icons.shopping_bag,
                color: Colors.grey[300]!,
                description: 'Untuk barang berat seperti elektronik, furniture, dll',
                weight: 'Berat (>20kg)',
                isDisabled: true,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required String description,
    required String weight,
    bool isDisabled = false,
  }) {
    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderPage(
                    user: user,
                    token: token,
                    selectedWeight: weight,
                  ),
                ),
              );
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey[200] : color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isDisabled
              ? null
              : [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 60,
              color: isDisabled ? Colors.grey[400] : Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDisabled ? Colors.grey[400] : Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: isDisabled ? Colors.grey[400] : Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}