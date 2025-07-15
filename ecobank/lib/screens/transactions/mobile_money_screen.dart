import 'package:flutter/material.dart';
import 'mobile_money_myself_screen.dart';
import 'mobile_money_beneficiary_screen.dart';

class MobileMoneyScreen extends StatelessWidget {
  final double accountBalance;
  final String userPhone;
  final String userName;
  final String userCountryCode;
  const MobileMoneyScreen({
    Key? key,
    required this.accountBalance,
    required this.userPhone,
    required this.userName,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Mobile Money',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F6FA),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: Row(
                children: const [
                  SizedBox(width: 12),
                  Icon(Icons.search, color: Color(0xFFBDBDBD)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFF5F6FA),
                    radius: 18,
                    child: const Text(
                      'M',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  title: const Text(
                    'Myself',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      height: 1.1,
                    ),
                  ),
                  onTap: () async {
                    final transaction = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MobileMoneyMyselfScreen(
                          accountBalance: accountBalance,
                          userPhone: userPhone,
                          userName: userName,
                          userCountryCode: userCountryCode,
                        ),
                      ),
                    );
                    if (transaction != null) {
                      Navigator.pop(context, transaction);
                    }
                  },
                  trailing: null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 56,
                  endIndent: 0,
                  color: Color(0xFFE0E0E0),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFF5F6FA),
                    radius: 18,
                    child: const Icon(
                      Icons.add,
                      color: Color(0xFF0B6FA4),
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'Send to a new beneficiary',
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      height: 1.1,
                    ),
                  ),
                  onTap: () async {
                    final transaction = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MobileMoneyBeneficiaryScreen(
                          accountBalance: accountBalance,
                          userCountryCode: userCountryCode,
                        ),
                      ),
                    );
                    if (transaction != null) {
                      Navigator.pop(context, transaction);
                    }
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Color(0xFFBDBDBD),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
