import 'package:flutter/material.dart';

// Map country codes to flag URLs
final Map<String, String> countryFlags = {
  '+233': 'assets/flags/gh.png', // Ghana
  '+234': 'assets/flags/ng.png', // Nigeria
  '+225': 'assets/flags/ci.png', // Ivory Coast
  '+213': 'assets/flags/dz.png', // Algeria
};

class HelpScreen extends StatelessWidget {
  final String userName;
  final String userCountryCode;
  const HelpScreen({
    Key? key,
    required this.userName,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? flagUrl = countryFlags[userCountryCode];
    return Scaffold(
      backgroundColor: Colors.white,
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
                  'Help',
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        children: [
          const SizedBox(height: 32),
          // Illustration/avatar
          Center(
            child: CircleAvatar(
              radius: 56,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/help_avatar.jpg'),
              child: null,
            ),
          ),
          const SizedBox(height: 24),
          // Greeting
          Center(
            child: Text(
              'Hello, $userName',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              'How can we help you today?',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 24),
          // Let's Chat button
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8DD94A),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Let's Chat",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Contact Us section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Color(0xFF2196C9),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 16),
                // Email
                Row(
                  children: [
                    const Icon(Icons.email_outlined, color: Color(0xFF2196C9)),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'EMAIL US',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'assist@ecobank.com',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Website
                Row(
                  children: [
                    const Icon(Icons.language, color: Color(0xFF2196C9)),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'OUR WEBSITE',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'https://www.ecobank.com',
                          style: TextStyle(fontSize: 15, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
