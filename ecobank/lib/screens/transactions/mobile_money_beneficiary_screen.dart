import 'package:flutter/material.dart';

class MobileMoneyBeneficiaryScreen extends StatefulWidget {
  final double accountBalance;
  final String userCountryCode;
  const MobileMoneyBeneficiaryScreen({
    Key? key,
    required this.accountBalance,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  State<MobileMoneyBeneficiaryScreen> createState() =>
      _MobileMoneyBeneficiaryScreenState();
}

class _MobileMoneyBeneficiaryScreenState
    extends State<MobileMoneyBeneficiaryScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController beneficiaryNameController =
      TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String selectedOperator = 'TELECEL CASH';
  double amount = 0.0;

  final List<String> operators = [
    'TELECEL CASH',
    'MTN MOBILE MONEY',
    'GHANAPAY',
  ];

  final Map<String, String> countryCurrencySymbols = {
    '+233': 'GHS',
    '+234': 'NGN',
    '+225': 'XOF CFAF',
    '+213': 'DZD',
  };

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
  void dispose() {
    amountController.dispose();
    phoneController.dispose();
    beneficiaryNameController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void _showOperatorDialog() async {
    final op = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Select network operator',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ],
              ),
            ),
            ...operators.map(
              (op) => ListTile(
                title: Text(op),
                trailing: selectedOperator == op
                    ? const Icon(
                        Icons.radio_button_checked,
                        color: Color(0xFF6DD400),
                      )
                    : const Icon(Icons.radio_button_off, color: Colors.grey),
                onTap: () => Navigator.pop(context, op),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
    if (op != null) {
      setState(() {
        selectedOperator = op;
      });
    }
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
          'Mobile Money',
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
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Enter amount'),
                  content: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: 'Amount'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
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
                      'Amount should be between 1.0 and 10000.0',
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
                              'Select account',
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
                              'Select network operator',
                              style: TextStyle(
                                color: Color(0xFF2196C9),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              selectedOperator,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Color(0xFFBDBDBD),
                            ),
                            onTap: _showOperatorDialog,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Mobile number',
                            style: TextStyle(
                              color: Color(0xFF2196C9),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: 'Enter mobile number',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Beneficiary name',
                            style: TextStyle(
                              color: Color(0xFF2196C9),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextFormField(
                            controller: beneficiaryNameController,
                            decoration: const InputDecoration(
                              hintText: 'Enter beneficiary name',
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: TextFormField(
                        controller: noteController,
                        decoration: const InputDecoration(
                          hintText: 'Add a note or #hashtag',
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6DD400),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            final double? amt = double.tryParse(
                              amountController.text,
                            );
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
                                const SnackBar(
                                  content: Text('Insufficient balance'),
                                ),
                              );
                              final transaction = {
                                'type': 'Mobile Money',
                                'subtitle':
                                    'To: ${beneficiaryNameController.text} (${phoneController.text})',
                                'amount': amt,
                                'status': 'FAILED',
                                'date': DateTime.now().toString(),
                                'operator': selectedOperator,
                                'mobile': phoneController.text,
                                'beneficiary': beneficiaryNameController.text,
                                'note': noteController.text,
                              };
                              Navigator.pop(context, transaction);
                              return;
                            }
                            if (phoneController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Enter mobile number'),
                                ),
                              );
                              return;
                            }
                            if (beneficiaryNameController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Enter beneficiary name'),
                                ),
                              );
                              return;
                            }
                            final transaction = {
                              'type': 'Mobile Money',
                              'subtitle':
                                  'To: ${beneficiaryNameController.text} (${phoneController.text})',
                              'amount': amt,
                              'status': 'SUCCESS',
                              'date': DateTime.now().toString(),
                              'operator': selectedOperator,
                              'mobile': phoneController.text,
                              'beneficiary': beneficiaryNameController.text,
                              'note': noteController.text,
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
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
