import 'package:flutter/material.dart';
import 'transfer_form_screen.dart';
import 'ecobank_domestic_screen.dart';
import 'other_local_bank_screen.dart';
import 'mobile_money_screen.dart';

class TransferOptionsScreen extends StatefulWidget {
  final double accountBalance;
  final String userPhone;
  final String userName;
  final String userCountryCode;
  const TransferOptionsScreen({
    Key? key,
    required this.accountBalance,
    required this.userPhone,
    required this.userName,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  State<TransferOptionsScreen> createState() => _TransferOptionsScreenState();
}

class _TransferOptionsScreenState extends State<TransferOptionsScreen> {
  int selectedTab = 0; // 0: Transfer, 1: Request

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6FA4),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Transfer',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          // Tab Switcher
          Container(
            color: const Color(0xFF0B6FA4),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 0),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedTab == 0
                              ? Colors.white
                              : const Color(0xFF0B6FA4),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Transfer',
                            style: TextStyle(
                              color: selectedTab == 0
                                  ? const Color(0xFF0B6FA4)
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTab = 1),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: selectedTab == 1
                              ? Colors.white
                              : const Color(0xFF0B6FA4),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Request',
                            style: TextStyle(
                              color: selectedTab == 1
                                  ? const Color(0xFF0B6FA4)
                                  : Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Transfer Options List
          Expanded(
            child: ListView(
              children: [
                _TransferOptionTile(
                  icon: Icons.compare_arrows,
                  iconColor: Color(0xFF0B6FA4),
                  title: 'Ecobank Domestic',
                  onTap: () async {
                    final transaction = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EcobankDomesticScreen(
                          accountBalance: widget.accountBalance,
                          userCountryCode: widget.userCountryCode,
                        ),
                      ),
                    );
                    if (transaction != null) {
                      Navigator.pop(context, transaction);
                    }
                  },
                ),
                _TransferOptionTile(
                  icon: Icons.account_balance,
                  iconColor: Color(0xFF0B6FA4),
                  title: 'Other Local Banks',
                  onTap: () async {
                    final transaction = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OtherLocalBankScreen(
                          accountBalance: widget.accountBalance,
                          userCountryCode: widget.userCountryCode,
                        ),
                      ),
                    );
                    if (transaction != null) {
                      Navigator.pop(context, transaction);
                    }
                  },
                ),
                _TransferOptionTile(
                  icon: Icons.phone_iphone,
                  iconColor: Color(0xFF0B6FA4),
                  title: 'Mobile Money',
                  onTap: () async {
                    final transaction = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MobileMoneyScreen(
                          accountBalance: widget.accountBalance,
                          userPhone: widget.userPhone,
                          userName: widget.userName,
                          userCountryCode: widget.userCountryCode,
                        ),
                      ),
                    );
                    if (transaction != null) {
                      Navigator.pop(context, transaction);
                    }
                  },
                ),
                _TransferOptionTile(
                  icon: Icons.event_note,
                  iconColor: Color(0xFF0B6FA4),
                  title: 'Standing order',
                  onTap: () async {
                    final transaction = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferFormScreen(
                          transferType: 'Standing order',
                          userCountryCode: widget.userCountryCode,
                          accountBalance: widget.accountBalance,
                        ),
                      ),
                    );
                    if (transaction != null) {
                      Navigator.pop(context, transaction);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransferOptionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final VoidCallback onTap;
  const _TransferOptionTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 28),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 18,
        color: Color(0xFFBDBDBD),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    );
  }
}
