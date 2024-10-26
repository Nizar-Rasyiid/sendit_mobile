import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FAQPage(),
    );
  }
}

class FAQPage extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      "question": "What is SendIt?",
      "answer":
          "SendIt is a mobile application for sending and receiving packages."
    },
    {
      "question": "How do I create an account?",
      "answer":
          "You can create an account by clicking on the 'Sign Up' button on the login screen."
    },
    {
      "question": "How do I track my package?",
      "answer":
          "You can track your package by entering the tracking number in the 'Track Package' section."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(faqs[index]['question']!),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faqs[index]['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
