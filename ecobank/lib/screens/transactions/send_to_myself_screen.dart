import 'package:flutter/material.dart';

// Map country codes to currency symbols
final Map<String, String> countryCurrencySymbols = {
  '+233': 'GHS', // Ghana
  '+234': 'NGN', // Nigeria
  '+225': 'XOF CFAF', // Ivory Coast
  '+213': 'DZD', // Algeria
  // Add more as needed
};

class SendToMyselfScreen extends StatefulWidget {
  final double accountBalance;
  final String userCountryCode;
  const SendToMyselfScreen({
    Key? key,
    required this.accountBalance,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  State<SendToMyselfScreen> createState() => _SendToMyselfScreenState();
}

class _SendToMyselfScreenState extends State<SendToMyselfScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  double amount = 0.0;
  String selectedAccount = 'Savings Account';

  List<Map<String, String>> get myAccounts => [
    {
      'name': 'Savings Account',
      'number': '1441003779491',
      'balance':
          '${countryCurrencySymbols[widget.userCountryCode] ?? 'GHS'} 5,420.30',
    },
    {
      'name': 'Investment Account',
      'number': '1441002511277',
      'balance':
          '${countryCurrencySymbols[widget.userCountryCode] ?? 'GHS'} 45,200.00',
    },
  ];

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      setState(() {
        amount = double.tryParse(amountController.text) ?? 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6FA4),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Transfer to Myself',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Large amount display (tappable)
          GestureDetector(
            onTap: () {
              _showAmountInputDialog(context);
            },
            child: Container(
              color: const Color(0xFF0B6FA4),
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      '${countryCurrencySymbols[widget.userCountryCode] ?? 'GHS'} ${amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap to enter amount',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Select source account
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(24, 8, 24, 0),
                            child: Text(
                              'From account',
                              style: TextStyle(
                                color: Color(0xFF2196C9),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              'XPRESS',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              '${countryCurrencySymbols[widget.userCountryCode] ?? 'GHS'} ' +
                                  widget.accountBalance.toStringAsFixed(2),
                              style: const TextStyle(color: Colors.black54),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Color(0xFFBDBDBD),
                            ),
                            onTap: () {},
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFE0E0E0),
                    ),
                    // Select destination account
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(24, 16, 24, 0),
                            child: Text(
                              'To account',
                              style: TextStyle(
                                color: Color(0xFF2196C9),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              selectedAccount,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              myAccounts.firstWhere(
                                (account) => account['name'] == selectedAccount,
                              )['number']!,
                              style: const TextStyle(color: Colors.black54),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Color(0xFFBDBDBD),
                            ),
                            onTap: () {
                              _showAccountSelectionDialog(context);
                            },
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFE0E0E0),
                    ),
                    // Note
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: TextFormField(
                        controller: noteController,
                        decoration: const InputDecoration(
                          hintText: 'Add a note (optional)',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Continue button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8DD94A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  final double? amt = double.tryParse(amountController.text);
                  if (amt == null || amt < 1.0 || amt > 10000.0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Enter a valid amount (min 1.0, max 10000.0)',
                        ),
                      ),
                    );
                    return;
                  }
                  if (amt > widget.accountBalance) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Insufficient balance')),
                    );
                    final transaction = {
                      'type': 'Send to Myself',
                      'amount': amt,
                      'status': 'FAILED',
                      'date': DateTime.now().toString(),
                      'subtitle': 'To ${selectedAccount}',
                    };
                    Navigator.pop(context, transaction);
                    return;
                  }
                  final transaction = {
                    'type': 'Ecobank Domestic (Myself)',
                    'amount': amt,
                    'status': 'SUCCESS',
                    'date': DateTime.now().toString(),
                    'subtitle': 'To ${selectedAccount}',
                  };
                  Navigator.pop(context, transaction);
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAmountInputDialog(BuildContext context) {
    final TextEditingController dialogController = TextEditingController();
    dialogController.text = amountController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Amount'),
          content: TextField(
            controller: dialogController,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Enter amount',
              prefixText:
                  '${countryCurrencySymbols[widget.userCountryCode] ?? 'GHS'} ',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final double? newAmount = double.tryParse(
                  dialogController.text,
                );
                if (newAmount != null && newAmount >= 0) {
                  setState(() {
                    amount = newAmount;
                    amountController.text = newAmount.toString();
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAccountSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Account'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: myAccounts.length,
              itemBuilder: (context, index) {
                final account = myAccounts[index];
                return ListTile(
                  title: Text(account['name']!),
                  subtitle: Text(
                    '${account['number']} - ${account['balance']}',
                  ),
                  onTap: () {
                    setState(() {
                      selectedAccount = account['name']!;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
