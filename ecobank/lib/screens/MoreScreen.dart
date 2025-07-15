import 'package:flutter/material.dart';

// Map country codes to flag URLs
final Map<String, String> countryFlags = {
  '+233': 'assets/flags/gh.png', // Ghana
  '+234': 'assets/flags/ng.png', // Nigeria
  '+225': 'assets/flags/ci.png', // Ivory Coast
  '+213': 'assets/flags/dz.png', // Algeria
};

class MoreScreen extends StatelessWidget {
  final String userCountryCode;
  const MoreScreen({Key? key, required this.userCountryCode}) : super(key: key);

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
                  'More Services',
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
        children: [
          _MoreServiceTile(
            icon: Icons.shield_outlined,
            iconColor: Color(0xFF2196C9),
            title: 'Settings',
            onTap: () {},
          ),
          _MoreServiceTile(
            icon: Icons.settings,
            iconColor: Color(0xFF2196C9),
            title: 'Manage Beneficiaries',
            onTap: () {},
          ),
          _MoreServiceTile(
            icon: Icons.account_balance_wallet_outlined,
            iconColor: Color(0xFF4CAF50),
            title: 'Loans and Deposits',
            onTap: () {},
          ),
          _MoreServiceTile(
            icon: Icons.receipt_long,
            iconColor: Color(0xFF2196C9),
            title: 'Full Statement',
            onTap: () {},
          ),
          _MoreServiceTile(
            icon: Icons.gavel_outlined,
            iconColor: Color(0xFF4CAF50),
            title: 'Legal',
            onTap: () {},
          ),
          _MoreServiceTile(
            icon: Icons.location_on_outlined,
            iconColor: Color(0xFF2196C9),
            title: 'Locate Us',
            onTap: () {},
          ),
          _MoreServiceTile(
            icon: Icons.contact_support_outlined,
            iconColor: Color(0xFF2196C9),
            title: 'Contact Us',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _MoreServiceTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;
  const _MoreServiceTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 28),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: Color(0xFFBDBDBD),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      horizontalTitleGap: 16,
    );
  }
}
