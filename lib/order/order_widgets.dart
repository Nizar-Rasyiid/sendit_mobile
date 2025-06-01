// import 'package:flutter/material.dart';

// class OrderWidgets {
//   static Widget buildAddressInput(TextEditingController controller, String? errorText,
//       String hint, IconData icon) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(
//                 color: errorText == null ? Colors.transparent : Colors.red),
//           ),
//           child: Row(
//             children: [
//               Icon(icon, color: Colors.grey),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: TextField(
//                   controller: controller,
//                   decoration: InputDecoration(
//                     hintText: hint,
//                     border: InputBorder.none,
//                     hintStyle: const TextStyle(color: Colors.grey),
//                   ),
//                   onSubmitted: (value) {
//                     print("Search for: $value");
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (errorText != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 4),
//             child: Text(
//               errorText,
//               style: const TextStyle(color: Colors.red, fontSize: 12),
//             ),
//           ),
//       ],
//     );
//   }

//   static Widget buildDistanceInfo(double totalDistance) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Total Jarak Pengiriman',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         Text('$totalDistance km', style: const TextStyle(color: Colors.grey)),
//       ],
//     );
//   }

//   static Widget buildPriceInfo(double price) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Total Harga Pengiriman',
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         Text(
//           'Rp ${price.toStringAsFixed(0)}',
//           style: const TextStyle(fontSize: 18, color: Colors.green)
//         ),
//       ],
//     );
//   }

//   static Widget buildSavedAddress(String name, String address) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey[300]!),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.location_on, color: Color(0xFF6C63FF)),
//           const SizedBox(width: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 address,
//                 style: TextStyle(color: Colors.grey[600], fontSize: 12),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// } 