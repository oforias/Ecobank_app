import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Center(
            child: Text(
              'Hello World',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        body: ListView(
          children: [
            ListTile(title: Text("Item 1")),
            ListTile(title: Text("Item 2")),
            ListTile(title: Text("Item 3")),
          ],
        ),
      ),
    );
  }
}
