// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:sendit/auth/urlPort.dart';
// import 'package:sendit/order/order_widgets.dart';
// import 'package:sendit/order/order_information_page.dart';

// class OrderPage extends StatefulWidget {
//   const OrderPage({super.key});

//   @override
//   _OrderPageState createState() => _OrderPageState();
// }

// class _OrderPageState extends State<OrderPage> {
//   String selectedWeight = 'Kecil (Maks 5kg)';
//   double totalDistance = 10.0;
//   double price = 0.0;
//   final int id_user = 1;
//   final int id_kurir = 3;

//   final TextEditingController senderAddressController = TextEditingController();
//   final TextEditingController receiverAddressController = TextEditingController();

//   String? senderAddressError;
//   String? receiverAddressError;

//   @override
//   void initState() {
//     super.initState();
//     _calculatePrice();
//   }

//   Future<void> submitOrder() async {
//     final url = Uri.parse('${urlPort}api/pemesanan');
    
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'id_user': id_user,
//           'id_kurir': id_kurir,
//           'jarak': totalDistance,
//           'lokasi_jemput': senderAddressController.text,
//           'lokasi_tujuan': receiverAddressController.text,
//           'status': 'On Progress',
//           'nama_penerima': 'Tes A',
//           'total_harga': price,
//           'metode_pembayaran': 'QRIS'
//         }),
//       );

//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 201) {
//         final orderData = json.decode(response.body);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OrderInformationPage(
//               orderId: orderData['id_pemesanan'],
//               totalPrice: price,
//               selectedWeight: selectedWeight,
//             ),
//           ),
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Error'),
//             content: Text('Failed to create order: ${response.statusCode}'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error detail: $e');
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Error'),
//           content: Text('Failed to connect to server: $e'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   void _calculatePrice() {
//     double pricePerKm = 3000;
//     double weightFactor;

//     if (selectedWeight == 'Kecil (Maks 5kg)') {
//       weightFactor = 1.0;
//     } else if (selectedWeight == 'Sedang (Maks 20kg)') {
//       weightFactor = 1.5;
//     } else {
//       weightFactor = 2.0;
//     }

//     setState(() {
//       price = totalDistance * pricePerKm * weightFactor;
//     });
//   }

//   bool _validateInputs() {
//     setState(() {
//       senderAddressError =
//           senderAddressController.text.isEmpty ? 'Alamat pengirim harus diisi.' : null;
//       receiverAddressError =
//           receiverAddressController.text.isEmpty ? 'Alamat penerima harus diisi.' : null;
//     });

//     return senderAddressError == null && receiverAddressError == null;
//   }

//   Future<void> _showWeightSelectionDialog() async {
//     String? selected = await showDialog<String>(
//       context: context,
//       builder: (BuildContext context) {
//         String tempWeight = selectedWeight;
//         return AlertDialog(
//           title: const Text('Pilih Berat Paket'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               RadioListTile<String>(
//                 title: const Text('Kecil (Maks 5kg)'),
//                 value: 'Kecil (Maks 5kg)',
//                 groupValue: tempWeight,
//                 onChanged: (value) {
//                   setState(() {
//                     tempWeight = value!;
//                   });
//                   Navigator.pop(context, tempWeight);
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('Sedang (Maks 20kg)'),
//                 value: 'Sedang (Maks 20kg)',
//                 groupValue: tempWeight,
//                 onChanged: (value) {
//                   setState(() {
//                     tempWeight = value!;
//                   });
//                   Navigator.pop(context, tempWeight);
//                 },
//               ),
//               RadioListTile<String>(
//                 title: const Text('Besar (Maks 100kg)'),
//                 value: 'Besar (Maks 100kg)',
//                 groupValue: tempWeight,
//                 onChanged: (value) {
//                   setState(() {
//                     tempWeight = value!;
//                   });
//                   Navigator.pop(context, tempWeight);
//                 },
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Batal'),
//             ),
//           ],
//         );
//       },
//     );

//     if (selected != null) {
//       setState(() {
//         selectedWeight = selected;
//         _calculatePrice();
//       });
//     }
//   }

//   Widget _buildWeightSelectionBox() {
//     return GestureDetector(
//       onTap: () {
//         _showWeightSelectionDialog();
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(color: Colors.grey[300]!)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(selectedWeight, style: const TextStyle(fontSize: 16)),
//             const Icon(Icons.arrow_drop_down, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF6C63FF),
//         elevation: 0,
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/sendit.png',
//               height: 24,
//               color: Colors.white,
//             ),
//             const SizedBox(width: 8),
//           ],
//         ),
//         actions: const [
//           CircleAvatar(
//             backgroundImage: AssetImage('assets/profile_picture.png'),
//             radius: 16,
//           ),
//           SizedBox(width: 16),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Center(
//                 child: Text(
//                   'Kirim Barang!',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               const Text(
//                 'Ambil paket di',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               OrderWidgets.buildAddressInput(senderAddressController, senderAddressError,
//                   'Masukkan alamat pengirim...', Icons.home),
//               const SizedBox(height: 12),

//               const Text(
//                 'Alamat Penerima',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               OrderWidgets.buildAddressInput(
//                   receiverAddressController,
//                   receiverAddressError,
//                   'Cari alamat penerima...',
//                   Icons.search),

//               const SizedBox(height: 12),
//               OrderWidgets.buildDistanceInfo(totalDistance),

//               const SizedBox(height: 24),
//               const Text(
//                 'Pilih Berat Paket',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 12),
//               _buildWeightSelectionBox(),

//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Saved addresses',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       print("View All clicked");
//                     },
//                     child: const Text('View All'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               OrderWidgets.buildSavedAddress('Rumah Catheez', 'Jl. Kembang Kertas No. 1'),
//               const SizedBox(height: 12),
//               OrderWidgets.buildSavedAddress('Rumah Mama', 'Jl. Bunga Matahari No. 3'),
//               const SizedBox(height: 24),

//               OrderWidgets.buildPriceInfo(price),

//               const SizedBox(height: 24),

//               ElevatedButton(
//                 onPressed: () async {
//                   if (_validateInputs()) {
//                     await submitOrder();
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF6C63FF),
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                 ),
//                 child: const Text('Lanjutkan',
//                     style: TextStyle(fontSize: 16, color: Colors.white)),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// } 