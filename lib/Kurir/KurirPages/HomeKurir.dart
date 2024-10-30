import 'package:flutter/material.dart';
import 'package:sendit/Kurir/KurirPages/HistoryKurir.dart';
import 'BottomNavigation.dart';

class HomeKurir extends StatefulWidget {
  const HomeKurir({Key? key}) : super(key: key);

  @override
  _HomeKurirState createState() => _HomeKurirState();
}

class _HomeKurirState extends State<HomeKurir> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF2FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        elevation: 0,
        title: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/sendit.png', // Make sure to add this asset
                height: 24,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors
                        .transparent, // White background for the profile circle
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Muhammad',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white // Purple color for the text
                            ),
                      ),
                      const SizedBox(width: 4),
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor:
                            Colors.white, // Purple background for the initial
                        child: Text(
                          'M',
                          style: TextStyle(
                            color: Color(
                                0xFF6C63FF), // White color for the initial
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
        actions: [
          // TextButton(
          //   onPressed: () {
          //     // Handle profile editing
          //   },
          //   child: const Text(
          //     'Profile',
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Menerima Pesanan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: isSwitched,
                            activeColor: const Color(0xFF6C63FF),
                            onChanged: (bool value) {
                              setState(() {
                                isSwitched = value;
                              });
                            },
                            inactiveTrackColor: const Color(0xFFEEF2FF),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Illustration Container
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/kurir.png',
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Action Cards
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C63FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/box.png',
                                    width: 24,
                                    height: 24,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Terima Pesanan!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Bersiap mengantar paket ke tempat tujuan',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // FAQ Card
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEF2FF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(15),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.help_outline,
                                    color: Color(0xFF6C63FF),
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'FAQ!',
                                          style: TextStyle(
                                            color: Color(0xFF6C63FF),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          'Butuh bantuan pengiriman?',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFF6C63FF),
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
