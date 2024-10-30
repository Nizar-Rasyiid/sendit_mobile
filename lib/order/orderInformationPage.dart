import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Tambahkan ini untuk mengimpor services
import 'package:sendit/payment/paymentPage.dart'; // Pastikan untuk mengimpor PaymentPage

class OrderInformationPage extends StatefulWidget {
  const OrderInformationPage({super.key});

  @override
  _OrderInformationPageState createState() => _OrderInformationPageState();
}

class _OrderInformationPageState extends State<OrderInformationPage> {
  String? selectedPackageType; // Menyimpan jenis paket yang dipilih
  final TextEditingController senderNameController = TextEditingController();
  final TextEditingController senderNumberController = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverNumberController =
      TextEditingController();
  final TextEditingController otherPackageController =
      TextEditingController(); // Controller untuk input jenis paket lainnya

  String? senderNameError;
  String? senderNumberError;
  String? receiverNameError;
  String? receiverNumberError;
  String? packageTypeError;
  String? otherPackageError;

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
            backgroundImage:
                AssetImage('assets/profile_picture.png'), // Tambahkan aset ini
            radius: 16,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            _buildInputField(
                'Nama Pengirim', senderNameController, senderNameError),
            const SizedBox(height: 16),
            _buildNumberInputField(
                'Nomor Pengirim', senderNumberController, senderNumberError),
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
            _buildInputField(
                'Nama Penerima', receiverNameController, receiverNameError),
            const SizedBox(height: 16),
            _buildNumberInputField('Nomor Penerima', receiverNumberController,
                receiverNumberError),
            const SizedBox(height: 24),

            // Detail Paket
            const Text(
              'Detail Paket',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildPackageTypeButtons(() {
              // Callback untuk memeriksa apakah paket sudah dipilih
              if (selectedPackageType == null) {
                setState(() {
                  packageTypeError = 'Silakan pilih jenis paket.';
                });
              } else {
                setState(() {
                  packageTypeError = null; // Clear error jika paket dipilih
                });
              }
            }),
            const SizedBox(height: 16),
            if (packageTypeError != null) ...[
              // Menampilkan pesan kesalahan untuk pemilihan paket
              const SizedBox(height: 4),
              Text(
                packageTypeError!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
            // Input untuk jenis paket lainnya jika dipilih
            if (selectedPackageType == 'Lainnya') ...[
              _buildInputField('Jenis Paket Lainnya', otherPackageController,
                  otherPackageError),
            ],
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                // Validasi input
                if (_validateInput()) {
                  // Navigasi ke halaman PaymentPage ketika tombol ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentPage()),
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
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, String? error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: error != null ? Colors.red : Colors.transparent,
                width: 1.5),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ],
    );
  }

  Widget _buildNumberInputField(
      String label, TextEditingController controller, String? error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: error != null ? Colors.red : Colors.transparent,
                width: 1.5),
          ),
          child: TextField(
            controller: controller,
            keyboardType:
                TextInputType.number, // Mengatur keyboard hanya untuk angka
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter
                  .digitsOnly, // Memastikan hanya angka yang dapat dimasukkan
              LengthLimitingTextInputFormatter(
                  13), // Membatasi input hingga 13 karakter
            ],
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error,
            style: const TextStyle(color: Colors.red, fontSize: 14),
          ),
        ],
      ],
    );
  }

  Widget _buildPackageTypeButtons(Function onPackageSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildPackageButton('Makanan', Icons.fastfood, onPackageSelected),
        _buildPackageButton('Baju', Icons.checkroom, onPackageSelected),
        _buildPackageButton('Dokumen', Icons.folder, onPackageSelected),
        _buildPackageButton(
            'Obat-obatan', Icons.medical_services, onPackageSelected),
        _buildPackageButton('Buku', Icons.book, onPackageSelected),
        _buildPackageButton('Lainnya', Icons.add, onPackageSelected),
      ],
    );
  }

  Widget _buildPackageButton(
      String label, IconData icon, Function onPackageSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackageType = label;
          onPackageSelected(); // Trigger the validation callback
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedPackageType == label
                  ? const Color(0xFF6C63FF)
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,
                color:
                    selectedPackageType == label ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
                color:
                    selectedPackageType == label ? Colors.black : Colors.black),
          ),
        ],
      ),
    );
  }

  bool _validateInput() {
    // Reset pesan kesalahan
    senderNameError = null;
    senderNumberError = null;
    receiverNameError = null;
    receiverNumberError = null;
    packageTypeError = null;
    otherPackageError = null;

    // Memeriksa apakah semua field terisi
    if (senderNameController.text.isEmpty) {
      setState(() {
        senderNameError = 'Nama Pengirim harus diisi.';
      });
    }

    if (senderNumberController.text.isEmpty ||
        senderNumberController.text.length > 13) {
      setState(() {
        senderNumberError = 'Nomor Pengirim harus diisi dan maksimal 13 angka.';
      });
    }

    if (receiverNameController.text.isEmpty) {
      setState(() {
        receiverNameError = 'Nama Penerima harus diisi.';
      });
    }

    if (receiverNumberController.text.isEmpty ||
        receiverNumberController.text.length > 13) {
      setState(() {
        receiverNumberError =
            'Nomor Penerima harus diisi dan maksimal 13 angka.';
      });
    }

    // Memeriksa apakah jenis paket sudah dipilih
    if (selectedPackageType == null) {
      setState(() {
        packageTypeError = 'Silakan pilih jenis paket.';
      });
    } else if (selectedPackageType == 'Lainnya' &&
        otherPackageController.text.isEmpty) {
      setState(() {
        otherPackageError = 'Jenis Paket Lainnya harus diisi.';
      });
    }

    // Mengembalikan false jika ada kesalahan
    return senderNameError == null &&
        senderNumberError == null &&
        receiverNameError == null &&
        receiverNumberError == null &&
        packageTypeError == null &&
        otherPackageError == null;
  }
}
