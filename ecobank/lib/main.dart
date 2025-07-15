import 'package:flutter/material.dart';
import 'screens/LoginScreen.dart';
import 'screens/HomeScreen.dart';
import 'screens/CardServicesScreen.dart';
import 'screens/HelpScreen.dart';
import 'screens/NotificationsScreen.dart';
import 'screens/MoreScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecobank Mobile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final String userName;
  final String userPhone;
  final String userCountryCode;
  const MainNavigation({
    Key? key,
    required this.userName,
    required this.userPhone,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> activities = [];

  List<Widget> get _pages => [
    HomeScreen(
      userName: widget.userName,
      userPhone: widget.userPhone,
      userCountryCode: widget.userCountryCode,
      activities: activities,
      onActivitiesChanged: (newActivities) {
        setState(() {
          activities = newActivities;
        });
      },
    ),
    CardServicesScreen(userCountryCode: widget.userCountryCode),
    HelpScreen(
      userName: widget.userName,
      userCountryCode: widget.userCountryCode,
    ),
    NotificationsScreen(
      activities: activities,
      userCountryCode: widget.userCountryCode,
    ),
    MoreScreen(userCountryCode: widget.userCountryCode),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Cards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
