import 'package:flutter/material.dart';

class OtherLocalBankScreen extends StatefulWidget {
  final double accountBalance;
  final String userCountryCode;
  const OtherLocalBankScreen({
    Key? key,
    required this.accountBalance,
    required this.userCountryCode,
  }) : super(key: key);

  @override
  State<OtherLocalBankScreen> createState() => _OtherLocalBankScreenState();
}

class _OtherLocalBankScreenState extends State<OtherLocalBankScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController beneficiaryNameController =
      TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController proxyIdController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  String sendUsing = 'Account Number';
  double amount = 0.0;
  String selectedBank = '';
  bool showBankField = false;
  bool showSendUsingDialog = false;
  bool showBankDialog = false;

  @override
  void initState() {
    super.initState();
    amountController.addListener(() {
      setState(() {
        amount = double.tryParse(amountController.text) ?? 0.0;
      });
    });
  }

  void _showSendUsingDialog() async {
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Send using'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'Account Number'),
            child: const Text('Account Number'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'Proxy ID'),
            child: const Text('Proxy ID'),
          ),
        ],
      ),
    );
    if (choice != null) {
      setState(() {
        sendUsing = choice;
      });
    }
  }

  void _showBankInputDialog() async {
    final controller = TextEditingController(text: selectedBank);
    final bank = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Beneficiary Bank'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Type bank name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (bank != null) {
      setState(() {
        selectedBank = bank;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedBeneficiaries = [
      {'name': 'Mmalebna   Zumah', 'account': '1441003779491', 'avatar': 'M'},
      {
        'name': 'Nana Kwaku Afriyie Ampadu-Boateng',
        'account': '1441003779445',
        'avatar': 'NK',
      },
      {
        'name': 'PRINCESS AYOMIDE ASIRU-BALOGUN',
        'account': '1441002511277',
        'avatar': 'PA',
      },
    ];
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
          'Other Local Banks',
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
          const SizedBox(height: 8),
          // Only 'Send to a new beneficiary' (no 'Myself')
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
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
                        builder: (context) => _OtherLocalBankFormScreen(
                          accountBalance: widget.accountBalance,
                          userCountryCode: widget.userCountryCode,
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Saved Beneficiaries
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Text(
              'SAVED BENEFICIARIES',
              style: TextStyle(
                color: Color(0xFF2196C9),
                fontWeight: FontWeight.w600,
                fontSize: 13,
                letterSpacing: 1.1,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: savedBeneficiaries.length,
              itemBuilder: (context, index) {
                final b = savedBeneficiaries[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFF5F6FA),
                    radius: 18,
                    child: Text(
                      b['avatar']!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  title: Text(
                    b['name']!,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      height: 1.1,
                    ),
                  ),
                  subtitle: Text(
                    b['account']!,
                    style: const TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: Color(0xFFBDBDBD),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                  onTap: () async {
                    final transaction = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _OtherLocalBankFormScreen(
                          accountBalance: widget.accountBalance,
                          userCountryCode: widget.userCountryCode,
                          beneficiaryName: b['name'],
                          accountNumber: b['account'],
                        ),
                      ),
                    );
                    if (transaction != null) {
                      Navigator.pop(context, transaction);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// The form screen for 'Send to a new beneficiary' for Other Local Banks
class _OtherLocalBankFormScreen extends StatefulWidget {
  final double accountBalance;
  final String userCountryCode;
  final String? beneficiaryName;
  final String? accountNumber;
  const _OtherLocalBankFormScreen({
    Key? key,
    required this.accountBalance,
    required this.userCountryCode,
    this.beneficiaryName,
    this.accountNumber,
  }) : super(key: key);

  @override
  State<_OtherLocalBankFormScreen> createState() =>
      _OtherLocalBankFormScreenState();
}

class _OtherLocalBankFormScreenState extends State<_OtherLocalBankFormScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController beneficiaryNameController =
      TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController proxyIdController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  String sendUsing = 'Account Number';
  double amount = 0.0;
  String selectedBank = '';

  @override
  void initState() {
    super.initState();
    if (widget.beneficiaryName != null) {
      beneficiaryNameController.text = widget.beneficiaryName!;
    }
    if (widget.accountNumber != null) {
      accountNumberController.text = widget.accountNumber!;
    }
    amountController.addListener(() {
      setState(() {
        amount = double.tryParse(amountController.text) ?? 0.0;
      });
    });
  }

  void _showSendUsingDialog() async {
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Send using'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'Account Number'),
            child: const Text('Account Number'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'Proxy ID'),
            child: const Text('Proxy ID'),
          ),
        ],
      ),
    );
    if (choice != null) {
      setState(() {
        sendUsing = choice;
      });
    }
  }

  void _showBankInputDialog() async {
    final controller = TextEditingController(text: selectedBank);
    final bank = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Beneficiary Bank'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Type bank name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('OK'),
          ),
        ],
      ),
    );
    if (bank != null) {
      setState(() {
        selectedBank = bank;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isProxy = sendUsing == 'Proxy ID';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6FA4),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Enter amount',
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
                    // Select account
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
                    // Send using
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
                              'Send using',
                              style: TextStyle(
                                color: Color(0xFF2196C9),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              sendUsing,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Color(0xFFBDBDBD),
                            ),
                            onTap: _showSendUsingDialog,
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
                    // Beneficiary Bank
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
                              'Beneficiary Bank',
                              style: TextStyle(
                                color: Color(0xFF2196C9),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ListTile(
                            title: Text(
                              selectedBank.isEmpty
                                  ? 'Select bank'
                                  : selectedBank,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Color(0xFFBDBDBD),
                            ),
                            onTap: _showBankInputDialog,
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
                    // Proxy ID or Account Number
                    if (isProxy)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        child: TextFormField(
                          controller: proxyIdController,
                          decoration: const InputDecoration(
                            hintText: 'Enter proxy id',
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                        child: TextFormField(
                          controller: accountNumberController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Enter beneficiary account',
                          ),
                        ),
                      ),
                    // Beneficiary name
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                      child: TextFormField(
                        controller: beneficiaryNameController,
                        decoration: const InputDecoration(
                          hintText: 'Beneficiary name',
                        ),
                      ),
                    ),
                    // Note
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
                            if (amt == null || amt <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Enter a valid amount'),
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
                                'type': 'Other Local Banks',
                                'amount': amt,
                                'status': 'FAILED',
                                'date': DateTime.now().toString(),
                                'subtitle': beneficiaryNameController.text,
                                'bank': selectedBank,
                                'sendUsing': sendUsing,
                                'proxyId': proxyIdController.text,
                                'accountNumber': accountNumberController.text,
                                'note': noteController.text,
                              };
                              Navigator.pop(context, transaction);
                              return;
                            }
                            if (selectedBank.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Enter beneficiary bank'),
                                ),
                              );
                              return;
                            }
                            if (isProxy && proxyIdController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Enter proxy ID')),
                              );
                              return;
                            }
                            if (!isProxy &&
                                accountNumberController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Enter beneficiary account'),
                                ),
                              );
                              return;
                            }
                            final transaction = {
                              'type': 'Other Local Banks',
                              'amount': amt,
                              'status': 'SUCCESS',
                              'date': DateTime.now().toString(),
                              'subtitle': beneficiaryNameController.text,
                              'bank': selectedBank,
                              'sendUsing': sendUsing,
                              'proxyId': proxyIdController.text,
                              'accountNumber': accountNumberController.text,
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

// Map country codes to currency symbols
final Map<String, String> countryCurrencySymbols = {
  '+233': 'GHS', // Ghana
  '+234': 'NGN', // Nigeria
  '+225': 'XOF CFAF', // Ivory Coast
  '+213': 'DZD', // Algeria
  // Add more as needed
};
