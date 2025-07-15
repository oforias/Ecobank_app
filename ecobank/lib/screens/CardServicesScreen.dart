import 'package:flutter/material.dart';

// Map country codes to flag URLs
final Map<String, String> countryFlags = {
  '+233': 'assets/flags/gh.png', // Ghana
  '+234': 'assets/flags/ng.png', // Nigeria
  '+225': 'assets/flags/ci.png', // Ivory Coast
  '+213': 'assets/flags/dz.png', // Algeria
};

class CardServicesScreen extends StatelessWidget {
  final String userCountryCode;
  const CardServicesScreen({Key? key, required this.userCountryCode})
    : super(key: key);

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
                  'Card Services',
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
          ListTile(
            leading: const Icon(Icons.credit_card, color: Color(0xFF2196C9)),
            title: const Text(
              'Virtual Cards',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFFBDBDBD),
            ),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 2,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.credit_card_outlined,
              color: Color(0xFF2196C9),
            ),
            title: const Text(
              'Debit Cards',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFFBDBDBD),
            ),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 2,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Color(0xFF2196C9)),
            title: const Text(
              'Manage Attached Cards',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFFBDBDBD),
            ),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 2,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Color(0xFF2196C9)),
            title: const Text(
              'Credit Card Repayment',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFFBDBDBD),
            ),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 2,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.account_balance_wallet_outlined,
              color: Color(0xFF2196C9),
            ),
            title: const Text(
              'Prepaid Card TopUp',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFFBDBDBD),
            ),
            onTap: () {},
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 2,
            ),
          ),
        ],
      ),
    );
  }
}
