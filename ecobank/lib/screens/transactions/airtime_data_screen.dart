import 'package:flutter/material.dart';

// Map country codes to currency symbols
final Map<String, String> countryCurrencySymbols = {
  '+233': 'GHS', // Ghana
  '+234': 'NGN', // Nigeria
  '+225': 'XOF CFAF', // Ivory Coast
  '+213': 'DZD', // Algeria
  // Add more as needed
};

class AirtimeDataScreen extends StatefulWidget {
  final double accountBalance;
  final String userPhone;
  final String userCountryCode;
  const AirtimeDataScreen({
    Key? key,
    required this.accountBalance,
    required this.userPhone,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  State<AirtimeDataScreen> createState() => _AirtimeDataScreenState();
}

class _AirtimeDataScreenState extends State<AirtimeDataScreen> {
  int selectedTab = 0; // 0: Buy Airtime, 1: Buy Data
  bool showForm = false;
  bool isMyself = false;
  String selectedProvider = 'MTN';
  final List<String> providers = ['MTN', 'Vodafone', 'AirtelTigo', 'Glo'];

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String formatPhone(String phone) {
    // Remove all non-digits
    String digits = phone.replaceAll(RegExp(r'\D'), '');
    // Remove leading 0 if present
    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    // Add 233 if not present
    if (!digits.startsWith('233')) {
      digits = '233$digits';
    }
    return digits;
  }

  void _selectOption(bool myself) {
    setState(() {
      isMyself = myself;
      showForm = true;
      if (myself) {
        phoneController.text = formatPhone(widget.userPhone);
      } else {
        phoneController.clear();
      }
    });
  }

  void _goBackToSelection() {
    setState(() {
      showForm = false;
      phoneController.clear();
      amountController.clear();
    });
  }

  void _processPurchase() {
    final double? amt = double.tryParse(amountController.text);
    if (amt == null || amt < 1.0 || amt > 10000.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enter a valid amount (min 1.0, max 10000.0)'),
        ),
      );
      return;
    }
    if (amt > widget.accountBalance) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Insufficient balance')));
      final transaction = {
        'type': 'Airtime/Data',
        'amount': amt,
        'status': 'FAILED',
        'date': DateTime.now().toString(),
        // ...other fields...
      };
      Navigator.pop(context, transaction);
      return;
    }

    final transaction = {
      'type': isMyself ? 'Airtime purchase' : 'Airtime to beneficiary',
      'amount': amt,
      'status': 'SUCCESS',
      'date': DateTime.now().toString(),
      'subtitle': phoneController.text,
    };
    Navigator.pop(context, transaction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            showForm ? Icons.arrow_back : Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: showForm
              ? _goBackToSelection
              : () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          showForm
              ? (isMyself
                    ? 'Buy Airtime for Myself'
                    : 'Send to New Beneficiary')
              : 'Airtime/Data',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: showForm ? _buildForm() : _buildSelectionScreen(),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: isMyself
                  ? CircleAvatar(
                      backgroundColor: const Color(0xFFF5F6FA),
                      radius: 28,
                      child: Text(
                        'M',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    )
                  : CircleAvatar(
                      backgroundColor: const Color(0xFFF5F6FA),
                      radius: 28,
                      child: Icon(
                        Icons.add,
                        color: Color(0xFF0B6FA4),
                        size: 28,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                isMyself ? 'Myself' : 'New Beneficiary',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Network Provider',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
                items: providers.map((provider) {
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
            const Text(
              'Phone Number',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              enabled: !isMyself,
              decoration: InputDecoration(
                hintText: 'Enter phone number',
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
            const Text(
              'Amount',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
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
                onPressed: _processPurchase,
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
    );
  }

  Widget _buildSelectionScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab Switcher
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => selectedTab = 0),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: selectedTab == 0
                          ? const Color(0xFF0B6FA4)
                          : Colors.white,
                      border: Border.all(color: const Color(0xFF0B6FA4)),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Buy Airtime',
                        style: TextStyle(
                          color: selectedTab == 0
                              ? Colors.white
                              : const Color(0xFF0B6FA4),
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
                    height: 44,
                    decoration: BoxDecoration(
                      color: selectedTab == 1
                          ? const Color(0xFF0B6FA4)
                          : Colors.white,
                      border: Border.all(color: const Color(0xFF0B6FA4)),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Buy Data',
                        style: TextStyle(
                          color: selectedTab == 1
                              ? Colors.white
                              : const Color(0xFF0B6FA4),
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
        // Heading
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Text(
            selectedTab == 0 ? 'Buy Airtime' : 'Buy Data',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Search Bar
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
        // List section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFF5F6FA),
                    radius: 18,
                    child: Text(
                      'M',
                      style: TextStyle(color: Colors.black, fontSize: 16),
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
                  onTap: () => _selectOption(true),
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
                  onTap: () => _selectOption(false),
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
        ),
      ],
    );
  }
}
