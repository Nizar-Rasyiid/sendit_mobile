import 'package:flutter/material.dart';
import 'package:sendit/auth/LoginKurir.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:sendit/auth/login.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background putih
          Container(
            color: Colors.white,
          ),

          // Gelombang ungu dengan WaveWidget
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: WaveWidget(
                config: CustomConfig(
                  gradients: [
                    [Color(0xFF4338CA), Color(0xFF6366F1)],
                    [Color(0xFF6366F1), Color(0xFF818CF8)],
                  ],
                  durations: [35000, 19440],
                  heightPercentages: [0.35, 0.45],
                  blur: MaskFilter.blur(BlurStyle.solid, 10),
                  gradientBegin: Alignment.bottomLeft,
                  gradientEnd: Alignment.topRight,
                ),
                waveAmplitude: 30,
                size: Size(double.infinity, 1000), // Ukuran tinggi gelombang
              ),
            ),
          ),

          // Konten utama
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: Column(
                children: [
                  // Logo dan welcome text section
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        Container(
                          width: 250,
                          height: 200,
                          decoration: BoxDecoration(
                            // color: Color(0xFF5C3BFF),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset('assets/dasLogo.png'),
                        ),
                        SizedBox(height: 50),
                        SizedBox(height: 150),
                        // Welcome text
                        Text(
                          'Selamat Datang\ndi SendIt',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Pilih kategori pengguna',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),

                        // Buttons
                        SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xFF5C3BFF),
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    side: BorderSide(
                                      color: Color(0xFF5C3BFF),
                                      width: 1,
                                    ),
                                    elevation: 0,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginKurir()));
                                    },
                                    child: Text(
                                      'Kurir',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Color(0xFF5C3BFF),
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginPage()));
                                        },
                                        child: Text(
                                          'Pengirim',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
