// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:sendit/auth/urlPort.dart';

// class OrderInformationPage extends StatefulWidget {
//   final int orderId;
//   final double totalPrice;
//   final String selectedWeight;
  
//   const OrderInformationPage({
//     Key? key,
//     required this.orderId,
//     required this.totalPrice,
//     required this.selectedWeight,
//   }) : super(key: key);

//   @override
//   _OrderInformationPageState createState() => _OrderInformationPageState();
// }

// class _OrderInformationPageState extends State<OrderInformationPage> {
//   String? selectedPackageType;
//   final TextEditingController senderNameController = TextEditingController();
//   final TextEditingController senderNumberController = TextEditingController();
//   final TextEditingController receiverNameController = TextEditingController();
//   final TextEditingController receiverNumberController = TextEditingController();
//   final TextEditingController otherPackageController = TextEditingController();
//   String selectedPaymentMethod = 'QRIS';

//   String? senderNameError;
//   String? senderNumberError;
//   String? receiverNameError;
//   String? receiverNumberError;
//   String? packageTypeError;
//   String? otherPackageError;

//   Future<void> updateOrderWithReceiverInfo(String selectedWeight) async {
//     final url = Uri.parse('${urlPort}api/pemesanan/${widget.orderId}');

//     try {
//       final response = await http.put(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: json.encode({
//           'nama_penerima': receiverNameController.text,
//           'no_hp_penerima': receiverNumberController.text,
//           'jenis_paket': selectedPackageType ?? '',
//           'keterangan': selectedPackageType == 'Lainnya'
//               ? otherPackageController.text
//               : '',
//           'metode_pembayaran': selectedPaymentMethod,
//         }),
//       );

//       if (response.statusCode == 200) {
//         // Handle successful update
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PaymentPage(
//               orderId: widget.orderId,
//               totalPrice: widget.totalPrice,
//               paymentMethod: selectedPaymentMethod,
//             ),
//           ),
//         );
//       } else {
//         throw Exception('Failed to update order');
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Error'),
//           content: Text('Failed to update order: $e'),
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

//   bool validateInputs() {
//     bool isValid = true;
//     setState(() {
//       senderNameError = senderNameController.text.isEmpty ? 'Required' : null;
//       senderNumberError = senderNumberController.text.isEmpty ? 'Required' : null;
//       receiverNameError = receiverNameController.text.isEmpty ? 'Required' : null;
//       receiverNumberError =
//           receiverNumberController.text.isEmpty ? 'Required' : null;
//       packageTypeError = selectedPackageType == null ? 'Required' : null;
//       if (selectedPackageType == 'Lainnya' &&
//           otherPackageController.text.isEmpty) {
//         otherPackageError = 'Please specify package type';
//         isValid = false;
//       }
//     });
//     return isValid &&
//         senderNameError == null &&
//         senderNumberError == null &&
//         receiverNameError == null &&
//         receiverNumberError == null &&
//         packageTypeError == null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order Information'),
//         backgroundColor: const Color(0xFF6C63FF),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Order details section
//             buildOrderDetails(),
//             const SizedBox(height: 24),

//             // Package type selection
//             buildPackageTypeSelection(),
//             const SizedBox(height: 24),

//             // Payment method selection
//             buildPaymentMethodSelection(),
//             const SizedBox(height: 24),

//             // Continue button
//             ElevatedButton(
//               onPressed: () {
//                 if (validateInputs()) {
//                   updateOrderWithReceiverInfo(widget.selectedWeight);
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFF6C63FF),
//                 minimumSize: const Size(double.infinity, 50),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//               ),
//               child: const Text('Continue to Payment',
//                   style: TextStyle(fontSize: 16)),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildOrderDetails() {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Order Details',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             Text('Order ID: ${widget.orderId}'),
//             Text('Total Price: Rp ${widget.totalPrice.toStringAsFixed(0)}'),
//             Text('Package Weight: ${widget.selectedWeight}'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildPackageTypeSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Package Type',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         DropdownButtonFormField<String>(
//           value: selectedPackageType,
//           decoration: InputDecoration(
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             errorText: packageTypeError,
//           ),
//           hint: const Text('Select package type'),
//           items: const [
//             DropdownMenuItem(value: 'Dokumen', child: Text('Dokumen')),
//             DropdownMenuItem(value: 'Elektronik', child: Text('Elektronik')),
//             DropdownMenuItem(value: 'Makanan', child: Text('Makanan')),
//             DropdownMenuItem(value: 'Lainnya', child: Text('Lainnya')),
//           ],
//           onChanged: (value) {
//             setState(() {
//               selectedPackageType = value;
//               if (value != 'Lainnya') {
//                 otherPackageController.clear();
//                 otherPackageError = null;
//               }
//             });
//           },
//         ),
//         if (selectedPackageType == 'Lainnya') ...[
//           const SizedBox(height: 8),
//           TextField(
//             controller: otherPackageController,
//             decoration: InputDecoration(
//               labelText: 'Specify package type',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               errorText: otherPackageError,
//             ),
//           ),
//         ],
//       ],
//     );
//   }

//   Widget buildPaymentMethodSelection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Payment Method',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         RadioListTile(
//           title: const Text('QRIS'),
//           value: 'QRIS',
//           groupValue: selectedPaymentMethod,
//           onChanged: (value) {
//             setState(() {
//               selectedPaymentMethod = value.toString();
//             });
//           },
//         ),
//         RadioListTile(
//           title: const Text('Cash'),
//           value: 'Cash',
//           groupValue: selectedPaymentMethod,
//           onChanged: (value) {
//             setState(() {
//               selectedPaymentMethod = value.toString();
//             });
//           },
//         ),
//       ],
//     );
//   }
// } 