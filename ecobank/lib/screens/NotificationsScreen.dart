import 'package:flutter/material.dart';

// Map country codes to flag URLs
final Map<String, String> countryFlags = {
  '+233': 'assets/flags/gh.png', // Ghana
  '+234': 'assets/flags/ng.png', // Nigeria
  '+225': 'assets/flags/ci.png', // Ivory Coast
  '+213': 'assets/flags/dz.png', // Algeria
};

class NotificationsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> activities;
  final String userCountryCode;
  const NotificationsScreen({
    Key? key,
    required this.activities,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<Map<String, dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = List<Map<String, dynamic>>.from(widget.activities);
  }

  @override
  void didUpdateWidget(NotificationsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activities != widget.activities) {
      setState(() {
        notifications = List<Map<String, dynamic>>.from(widget.activities);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? flagUrl = countryFlags[widget.userCountryCode];
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6FA),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          color: const Color(0xFF0B6FA4),
          padding: const EdgeInsets.only(
            top: 52,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.amber,
                child: Icon(
                  Icons.person_outline_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const Expanded(
                child: Text(
                  'Notifications',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                children: [
                  if (flagUrl != null)
                    Image.asset(
                      flagUrl,
                      width: 32,
                      height: 22,
                      fit: BoxFit.cover,
                    ),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Switch off notifications',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                Switch(
                  value: true,
                  activeColor: const Color(0xFF8DD94A),
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 18, 16, 8),
            child: Text(
              'NEW NOTIFICATIONS',
              style: TextStyle(
                color: Color(0xFF2196C9),
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Expanded(
            child: notifications.isEmpty
                ? const Center(
                    child: Text(
                      'No new notifications.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return Container(
                        color: Colors.white,
                        margin: const EdgeInsets.only(bottom: 2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 0,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFF6F6FA),
                            child: Icon(
                              notification['icon'] as IconData,
                              color: const Color(0xFF2196C9),
                            ),
                          ),
                          title: Text(
                            notification['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['subtitle'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    notification['amount'] as String,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    notification['status'] as String,
                                    style: TextStyle(
                                      color:
                                          notification['statusColor'] as Color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification['date'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          contentPadding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
