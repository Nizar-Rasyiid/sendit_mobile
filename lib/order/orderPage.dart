import 'package:flutter/material.dart';
import 'orderInformationPage.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String selectedWeight = 'Kecil (Maks 5kg)'; // Default pilihan berat
  double totalDistance = 10.0; // Contoh jarak pengiriman
  double price = 0.0; // Harga berdasarkan jarak dan berat

  // Controllers for address inputs
  final TextEditingController senderAddressController = TextEditingController();
  final TextEditingController receiverAddressController =
      TextEditingController();

  // Error messages
  String? senderAddressError;
  String? receiverAddressError;

  @override
  void initState() {
    super.initState();
    _calculatePrice(); // Hitung harga saat inisialisasi
  }

  void _calculatePrice() {
    double pricePerKm = 3000; // Misalnya 5000 per kilometer
    double weightFactor;

    if (selectedWeight == 'Kecil (Maks 5kg)') {
      weightFactor = 1.0;
    } else if (selectedWeight == 'Sedang (Maks 20kg)') {
      weightFactor = 1.5;
    } else {
      weightFactor = 2.0;
    }

    setState(() {
      price = totalDistance * pricePerKm * weightFactor;
    });
  }

  // Validate form inputs
  bool _validateInputs() {
    setState(() {
      senderAddressError = senderAddressController.text.isEmpty
          ? 'Alamat pengirim harus diisi.'
          : null;
      receiverAddressError = receiverAddressController.text.isEmpty
          ? 'Alamat penerima harus diisi.'
          : null;
    });

    return senderAddressError == null && receiverAddressError == null;
  }

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
          ],
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage(
                'assets/profile_picture.png'), // Pastikan aset ini ada
            radius: 16,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Kirim Barang!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Input untuk alamat pengirim
              const Text(
                'Ambil paket di',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildAddressInput(senderAddressController, senderAddressError,
                  'Masukkan alamat pengirim...', Icons.home),
              const SizedBox(height: 12),

              // Input untuk alamat penerima
              const Text(
                'Alamat Penerima',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildAddressInput(
                  receiverAddressController,
                  receiverAddressError,
                  'Cari alamat penerima...',
                  Icons.search),

              const SizedBox(height: 12),
              _buildDistanceInfo(), // Informasi jarak pengiriman

              const SizedBox(height: 24),

              // Pilihan untuk berat paket dengan tampilan box yang lebih rapi
              const Text(
                'Pilih Berat Paket',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildWeightSelectionBox(), // Box untuk pilihan berat

              const SizedBox(height: 24),

              // Bagian untuk alamat yang disimpan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Saved addresses',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle view all saved addresses
                      print("View All clicked");
                    },
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildSavedAddress('Rumah Catheez', 'Jl. Kembang Kertas No. 1'),
              const SizedBox(height: 12),
              _buildSavedAddress('Rumah Mama', 'Jl. Bunga Matahari No. 3'),
              const SizedBox(height: 24),

              // Tambahkan harga di bawah Saved Addresses
              _buildPriceInfo(),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_validateInputs()) {
                    // Navigate to the recipient information page if validation is successful
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderInformationPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6C63FF),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Lanjutkan',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressInput(TextEditingController controller, String? errorText,
      String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
                color: errorText == null ? Colors.transparent : Colors.red),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                  onSubmitted: (value) {
                    // You can handle search functionality here
                    print("Search for: $value");
                  },
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) // Display error message below the input box
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  // Informasi Jarak Pengiriman
  Widget _buildDistanceInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Jarak Pengiriman',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text('$totalDistance km', style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  // Widget untuk box pilihan berat
  Widget _buildWeightSelectionBox() {
    return GestureDetector(
      onTap: () {
        _showWeightSelectionDialog();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey[300]!)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(selectedWeight, style: const TextStyle(fontSize: 16)),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Dialog Pilihan Berat Paket
  Future<void> _showWeightSelectionDialog() async {
    String? selected = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        String tempWeight = selectedWeight; // Store temporary selection
        return AlertDialog(
          title: const Text('Pilih Berat Paket'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Kecil (Maks 5kg)'),
                value: 'Kecil (Maks 5kg)',
                groupValue: tempWeight,
                onChanged: (value) {
                  setState(() {
                    tempWeight = value!;
                  });
                  Navigator.pop(context, tempWeight);
                },
              ),
              RadioListTile<String>(
                title: const Text('Sedang (Maks 20kg)'),
                value: 'Sedang (Maks 20kg)',
                groupValue: tempWeight,
                onChanged: (value) {
                  setState(() {
                    tempWeight = value!;
                  });
                  Navigator.pop(context, tempWeight);
                },
              ),
              RadioListTile<String>(
                title: const Text('Besar (Maks 100kg)'),
                value: 'Besar (Maks 100kg)',
                groupValue: tempWeight,
                onChanged: (value) {
                  setState(() {
                    tempWeight = value!;
                  });
                  Navigator.pop(context, tempWeight);
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );

    setState(() {
      // selectedWeight = selected!;
      _calculatePrice();
    });
  }

  Widget _buildPriceInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Harga Pengiriman',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text('Rp ${price.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 18, color: Colors.green)),
      ],
    );
  }

  Widget _buildSavedAddress(String name, String address) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Color(0xFF6C63FF)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                address,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
