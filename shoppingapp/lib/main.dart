import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() => runApp(
  MaterialApp(
    initialRoute: '/',
    routes: {'/': (context) => ECommerceHomePage()},
  ),
);
