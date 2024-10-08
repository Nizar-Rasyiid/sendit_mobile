import 'package:flutter/material.dart';
import 'package:sendit/home/historyPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: _buildAppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPromoSection(),
                  const SizedBox(height: 24),
                  _buildFeatureSection(),
                  const SizedBox(height: 24),
                  _buildCategorySection(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF6C63FD),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/sendit.png'),
      ),
      title: const Text(
        'SendIt!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              const Text(
                'User',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundImage: AssetImage('assets/profile_image.png'),
                radius: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPromoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Promo Menarik',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6C63FD), Color(0xFF4834DF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Buat Tetangga!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Diskon hingga 30% untuk pengiriman dalam kota',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        iconColor: Colors.white,
                        shadowColor: Color(0xFF6C63FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        'Kirim Sekarang!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/ilustrasi_login.png',
                height: 120,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fitur',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FeatureCard(
                icon: Icons.local_shipping,
                label: 'Kirim Barang',
                backgroundColor: Color(0xFF6C63FD),
                onTap: () {},
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: FeatureCard(
                icon: Icons.help_outline,
                label: 'FAQ',
                backgroundColor: Color(0xFF4834DF),
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Kategori',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CategoryCard(
                icon: Icons.widgets_outlined,
                label: 'Ringan',
                backgroundColor: Color(0xFF6C63FD),
                onTap: () {},
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CategoryCard(
                icon: Icons.inventory_2_outlined,
                label: 'Berat',
                backgroundColor: Color(0xFF4834DF),
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF6C63FD),
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      onTap: (index) {
        if (index == 0) {
          // Handle tap on index 0 (e.g., navigate to home page)
        } else if (index == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HistoryPage()));
        }
        // Add more cases for other indices if needed
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Tracking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  const FeatureCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
