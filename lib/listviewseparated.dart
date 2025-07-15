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
        body: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) => ListTile(title: Text('Row $index')),
          separatorBuilder: (context, index) => Divider(color: Colors.grey),
        ),
      ),
    );
  }
}
