import 'package:flutter/material.dart';
import 'package:listview/pages/home_page.dart';
import 'package:listview/pages/productlist.dart';

void main() => runApp(
  MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => ECommerceHomePage(),
      '/details': (context) => ProductApp(),
    },
  ),
);
