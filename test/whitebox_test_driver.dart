// import 'package:flutter_test/flutter_test.dart';
// import 'whitebox_test_suite.dart';
// import 'dart:io';

// void main() {
//   testWidgets('Run Whitebox Test Suite and save report',
//       (WidgetTester tester) async {
//     print('Starting test suite...');

//     final testSuite = WhiteboxTestSuite();
//     print('Created test suite instance');

//     testSuite.runAllTests();
//     print('Ran all tests');

//     final report = testSuite.generateReport();
//     print('Generated report:');
//     print(report);

//     try {
//       final file = File('test/whitebox_test_report.txt');
//       await file.writeAsString(report);
//       print('Successfully wrote report to file');
//     } catch (e) {
//       print('Error writing report to file: $e');
//     }
//   });
// }
