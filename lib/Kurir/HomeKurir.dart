import 'package:flutter/material.dart';
import 'package:sendit/Kurir/OrderList.dart';
import 'package:sendit/home/ProfilePage.dart';
import 'package:sendit/home/historyPage.dart';

class HomeKurir extends StatefulWidget {
  const HomeKurir({Key? key}) : super(key: key);

  @override
  _HomeKurirState createState() => _HomeKurirState();
}

class _HomeKurirState extends State<HomeKurir> {
  int _selectedIndex = 0; // Indeks halaman saat ini

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF6C63FD),
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _homeContent();
      case 1:
        return HistoryPage(); 
      case 2:
        return ProfilePage();
      default:
        return _homeContent();
    }
  }

  Widget _homeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Menerima Pesanan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Oke',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  'assets/kurir.png',
                  height: 200, // Sesuaikan tinggi gambar jika diperlukan
                ),
              ),
              const SizedBox(height: 32),
              _buildCustomButton(
                icon: Icons.add,
                text: 'Tombol 1',
                subText: 'Subteks Tombol 1',
                onPressed: () {
                  // Tambahkan aksi tombol pertama di sini
                },
              ),
              const SizedBox(height: 16),
              _buildCustomButton(
                icon: Icons.info,
                text: 'Tombol 2',
                subText: 'Subteks Tombol 2',
                onPressed: () {
                  // Tambahkan aksi tombol kedua di sini
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton({
    required IconData icon,
    required String text,
    required String subText,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6C63FD),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 36), // Ukuran ikon lebih besar
              const SizedBox(width: 8), // Jarak antara ikon dan teks
            ],
          ),
          const SizedBox(height: 8), // Jarak antara row ikon dan teks
          Column(
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subText,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70, // Warna subteks
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF6C63FD),
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Image.asset('assets/sendit.png'),
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
}
