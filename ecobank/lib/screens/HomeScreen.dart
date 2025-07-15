import 'package:flutter/material.dart';
import 'transactions/airtime_data_screen.dart';
import 'transactions/pay_bill_screen.dart';
import 'transactions/xpress_cash_screen.dart';
import 'transactions/ecobank_pay_screen.dart';
import 'transactions/split_payments_screen.dart';
import 'transactions/transfer_options_screen.dart';

// Map country codes to flag URLs
final Map<String, String> countryFlags = {
  '+233': 'assets/flags/gh.png', // Ghana
  '+234': 'assets/flags/ng.png', // Nigeria
  '+225': 'assets/flags/ci.png', // Ivory Coast
  '+213': 'assets/flags/dz.png', // Algeria
};

// Map country codes to currency symbols
final Map<String, String> countryCurrencySymbols = {
  '+233': 'GHS', // Ghana
  '+234': 'NGN', // Nigeria
  '+225': 'XOF CFAF', // Ivory Coast
  '+213': 'DZD', // Algeria
  // Add more as needed
};

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userPhone;
  final String userCountryCode;
  final List<Map<String, dynamic>> activities;
  final Function(List<Map<String, dynamic>>) onActivitiesChanged;
  const HomeScreen({
    Key? key,
    required this.userName,
    required this.userPhone,
    required this.userCountryCode,
    required this.activities,
    required this.onActivitiesChanged,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showBalance = false;
  double accountBalance = 25219.96;
  late List<Map<String, dynamic>> activities;

  @override
  void initState() {
    super.initState();
    activities = List<Map<String, dynamic>>.from(widget.activities);
  }

  Future<void> _openAirtimeDataScreen() async {
    final transaction = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AirtimeDataScreen(
          accountBalance: accountBalance,
          userPhone: widget.userPhone,
          userCountryCode: widget.userCountryCode,
        ),
      ),
    );
    if (transaction != null && transaction is Map) {
      String userCountryCode = widget.userCountryCode;
      String currencySymbol = countryCurrencySymbols[userCountryCode] ?? 'GHS';
      setState(() {
        activities.insert(0, {
          'icon': Icons.phone,
          'title': transaction['type'] ?? 'Airtime purchase',
          'subtitle': transaction['subtitle'] ?? '',
          'amount': formatCurrency(
            transaction['amount'] as double,
            currencySymbol,
          ),
          'status': transaction['status'] ?? 'SUCCESS',
          'statusColor': Colors.green,
          'date': DateTime.now().toString(),
        });
        if ((transaction['status'] ?? 'SUCCESS') == 'SUCCESS') {
          accountBalance -= (transaction['amount'] as double);
        }
      });
      widget.onActivitiesChanged(activities);
    }
  }

  @override
  Widget build(BuildContext context) {
    String userCountryCode = widget.userCountryCode;
    String? flagUrl = countryFlags[userCountryCode];
    String currencySymbol = countryCurrencySymbols[userCountryCode] ?? 'GHS';

    return Scaffold(
      backgroundColor: const Color(0xFF0B6FA4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: const Color(0xFF0B6FA4),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 24,
                                backgroundColor: Colors.amber,
                                child: Icon(
                                  Icons.person_outline_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Welcome back,',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                widget.userName.isNotEmpty
                                    ? widget.userName
                                    : 'User',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                        // Dynamic country flag
                        if (flagUrl != null)
                          SizedBox(
                            width: 32,
                            height: 22,
                            child: Image.asset(flagUrl, fit: BoxFit.cover),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 2,
                      color: Colors.white24,
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: const [
                        Text(
                          'MY ACCOUNTS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.1,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'VIEW ALL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Account Card
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196C9),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Xpress Account',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(
                                  Icons.settings_outlined,
                                  color: Colors.white70,
                                  size: 22,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const Text(
                            '1441004724323',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 18),
                          // Show balance row
                          if (showBalance)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      formatCurrency(
                                        accountBalance,
                                        currencySymbol,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    const Text(
                                      'Available balance',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.white),
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(60, 36),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text('More'),
                                ),
                              ],
                            )
                          else
                            Center(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.white),
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size.fromHeight(44),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showBalance = true;
                                  });
                                },
                                child: const Text('Show my balance'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // White background for Quick Transaction and below
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick Transaction Section
                    Row(
                      children: const [
                        Text(
                          'QUICK TRANSACTION',
                          style: TextStyle(
                            color: Color(0xFF2196C9),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF2196C9),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2.8,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: _QuickActionButton(
                            icon: Icons.phone_android,
                            label: 'Airtime/Data',
                            onTap: _openAirtimeDataScreen,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: _QuickActionButton(
                            icon: Icons.sync_alt,
                            label: 'Transfer',
                            onTap: () async {
                              final transaction = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransferOptionsScreen(
                                    accountBalance: accountBalance,
                                    userPhone: widget.userPhone,
                                    userName: widget.userName,
                                    userCountryCode: widget.userCountryCode,
                                  ),
                                ),
                              );
                              if (transaction != null) {
                                String userCountryCode = widget.userCountryCode;
                                String currencySymbol =
                                    countryCurrencySymbols[userCountryCode] ??
                                    'GHS';
                                setState(() {
                                  activities.insert(0, {
                                    'icon':
                                        transaction['type'] == 'Mobile Money'
                                        ? Icons.mobile_friendly
                                        : Icons.sync_alt,
                                    'title': transaction['type'],
                                    'subtitle': transaction['subtitle'],
                                    'amount':
                                        '-${formatCurrency(transaction['amount'] as double, currencySymbol)}',
                                    'status': transaction['status'],
                                    'statusColor':
                                        transaction['status'] == 'SUCCESS'
                                        ? Colors.green
                                        : Colors.red,
                                    'date': DateTime.now().toString(),
                                  });
                                  if (transaction['status'] == 'SUCCESS') {
                                    accountBalance -= transaction['amount'];
                                  }
                                });
                                widget.onActivitiesChanged(activities);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: _QuickActionButton(
                            icon: Icons.receipt_long,
                            label: 'Pay Bill',
                            onTap: () async {
                              final transaction = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PayBillScreen(
                                    accountBalance: accountBalance,
                                    userCountryCode: userCountryCode,
                                  ),
                                ),
                              );
                              if (transaction != null) {
                                String userCountryCode = widget.userCountryCode;
                                String currencySymbol =
                                    countryCurrencySymbols[userCountryCode] ??
                                    'GHS';
                                setState(() {
                                  activities.insert(0, {
                                    'icon': Icons.receipt_long,
                                    'title': transaction['type'],
                                    'subtitle': transaction['subtitle'],
                                    'amount':
                                        '-${formatCurrency(transaction['amount'] as double, currencySymbol)}',
                                    'status': transaction['status'],
                                    'statusColor':
                                        transaction['status'] == 'SUCCESS'
                                        ? Colors.green
                                        : Colors.red,
                                    'date': DateTime.now().toString(),
                                  });
                                  if (transaction['status'] == 'SUCCESS') {
                                    accountBalance -= transaction['amount'];
                                  }
                                });
                                widget.onActivitiesChanged(activities);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: _QuickActionButton(
                            icon: Icons.attach_money,
                            label: 'Xpress Cash',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => XpressCashScreen(
                                    accountBalance: accountBalance,
                                    userCountryCode: userCountryCode,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: _QuickActionButton(
                            icon: Icons.qr_code,
                            label: 'EcobankPay',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EcobankPayScreen(
                                    accountBalance: accountBalance,
                                    userCountryCode: userCountryCode,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: _QuickActionButton(
                            icon: Icons.call_split,
                            label: 'Split Payments',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SplitPaymentsScreen(
                                    accountBalance: accountBalance,
                                    userCountryCode: userCountryCode,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          'YOUR ACTIVITY',
                          style: TextStyle(
                            color: Color(0xFF2196C9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF2196C9),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    activities.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: Text(
                                'No activity yet.',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: activities.length,
                            itemBuilder: (context, index) {
                              final activity = activities[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue.shade50,
                                  child: Icon(
                                    activity['icon'] as IconData,
                                    color: Color(0xFF2196C9),
                                  ),
                                ),
                                title: Text(
                                  activity['title'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(activity['subtitle'] as String),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      activity['amount'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      activity['status'] as String,
                                      style: TextStyle(
                                        color: activity['statusColor'] as Color,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                isThreeLine:
                                    (activity['subtitle'] as String).isNotEmpty,
                                dense: true,
                              );
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  const _QuickActionButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Color(0xFF2196C9)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatCurrency(double amount, String symbol) {
  return '$symbol ${amount.toStringAsFixed(2)}';
}
