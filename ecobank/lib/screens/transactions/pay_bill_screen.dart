import 'package:flutter/material.dart';

// Map country codes to currency symbols
final Map<String, String> countryCurrencySymbols = {
  '+233': 'GHS', // Ghana
  '+234': 'NGN', // Nigeria
  '+225': 'XOF CFAF', // Ivory Coast
  '+213': 'DZD', // Algeria
  // Add more as needed
};

class PayBillScreen extends StatefulWidget {
  final double accountBalance;
  final String userCountryCode;
  const PayBillScreen({
    Key? key,
    required this.accountBalance,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  State<PayBillScreen> createState() => _PayBillScreenState();
}

class _PayBillScreenState extends State<PayBillScreen> {
  String selectedBillType = 'Electricity';
  String selectedProvider = 'ECG';
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController meterNumberController = TextEditingController();

  final Map<String, List<String>> billProviders = {
    'Electricity': ['ECG', 'NEDCo', 'VRA'],
    'Water': ['GWCL', 'AVRL'],
    'Internet': ['Vodafone', 'MTN', 'AirtelTigo'],
    'TV': ['DSTV', 'GOTV', 'Startimes'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6FA4),
        foregroundColor: Colors.white,
        title: const Text(
          'Pay Bill',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Container(
              width: double.infinity,
              color: const Color(0xFF0B6FA4),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pay Your Bills',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pay electricity, water, internet and TV bills',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            // Form section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bill type selection
                  const Text(
                    'Bill Type',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedBillType,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: billProviders.keys.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBillType = value!;
                          selectedProvider = billProviders[value]!.first;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Provider selection
                  const Text(
                    'Service Provider',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: selectedProvider,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      items: billProviders[selectedBillType]!.map((provider) {
                        return DropdownMenuItem(
                          value: provider,
                          child: Text(provider),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedProvider = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Account/Meter number
                  Text(
                    selectedBillType == 'Electricity'
                        ? 'Meter Number'
                        : 'Account Number',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: selectedBillType == 'Electricity'
                        ? meterNumberController
                        : accountNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: selectedBillType == 'Electricity'
                          ? 'Enter meter number'
                          : 'Enter account number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF0B6FA4)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Amount
                  const Text(
                    'Amount',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter amount',
                      prefixText:
                          '${countryCurrencySymbols[widget.userCountryCode] ?? 'GHS'} ',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0xFF0B6FA4)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B6FA4),
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
                            'type': 'Pay Bill',
                            'amount': amt,
                            'status': 'FAILED',
                            'date': DateTime.now().toString(),
                            'billType': selectedBillType,
                            'provider': selectedProvider,
                            'accountNumber': selectedBillType == 'Electricity'
                                ? meterNumberController.text
                                : accountNumberController.text,
                          };
                          Navigator.pop(context, transaction);
                          return;
                        }
                        final String accountNumber =
                            selectedBillType == 'Electricity'
                            ? meterNumberController.text
                            : accountNumberController.text;

                        if (accountNumber.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please enter ${selectedBillType == 'Electricity' ? 'meter' : 'account'} number',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        final transaction = {
                          'type': 'Bill Payment',
                          'subtitle':
                              '$selectedBillType - $selectedProvider (${selectedBillType == 'Electricity' ? 'Meter' : 'Account'}: $accountNumber)',
                          'amount': amt,
                          'status': 'SUCCESS',
                          'date': DateTime.now().toString(),
                          'billType': selectedBillType,
                          'provider': selectedProvider,
                          'accountNumber': accountNumber,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
