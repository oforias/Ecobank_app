import 'package:flutter/material.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, String>> countries = [
    {'name': 'Ghana', 'flag': 'assets/flags/gh.png', 'prefix': '+233'},
    {'name': 'Nigeria', 'flag': 'assets/flags/ng.png', 'prefix': '+234'},
    {'name': 'Ivory Coast', 'flag': 'assets/flags/ci.png', 'prefix': '+225'},
    {'name': 'Algeria', 'flag': 'assets/flags/dz.png', 'prefix': '+213'},
  ];
  int? selectedCountryIndex;

  void _showCountryPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Select your country'),
          children: countries.asMap().entries.map((entry) {
            int idx = entry.key;
            var country = entry.value;
            return SimpleDialogOption(
              onPressed: () {
                setState(() {
                  selectedCountryIndex = idx;
                });
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Image.asset(country['flag']!, width: 24, height: 16),
                  const SizedBox(width: 8),
                  Text(country['name']!),
                  const SizedBox(width: 8),
                  Text(
                    country['prefix']!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _proceed() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigation(
            userName: _nameController.text.trim(),
            userPhone: _phoneController.text.trim(),
            userCountryCode: countries[selectedCountryIndex!]['prefix']!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top bar: Language selector and search icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/flags/us.png',
                              width: 20,
                              height: 14,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'EN',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const Icon(Icons.arrow_drop_down, size: 20),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Color(0xFF2196C9),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Welcome message
                  const Text(
                    'Welcome to Ecobank',
                    style: TextStyle(
                      color: Color(0xFF2196C9),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Have an Ecobank account?\nEnter your mobile number to get started',
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 32),
                  // Full Name
                  const Text(
                    'Full Name',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your full name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Country picker
                  GestureDetector(
                    onTap: _showCountryPicker,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      child: Row(
                        children: [
                          selectedCountryIndex != null
                              ? Text(countries[selectedCountryIndex!]['name']!)
                              : const Text(
                                  'Please select your country',
                                  style: TextStyle(color: Colors.grey),
                                ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Phone number input with flag and prefix
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      children: [
                        if (selectedCountryIndex != null) ...[
                          Image.asset(
                            countries[selectedCountryIndex!]['flag']!,
                            width: 24,
                            height: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            countries[selectedCountryIndex!]['prefix']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: 'Enter mobile number',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (selectedCountryIndex == null) {
                                return 'Select your country';
                              }
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter your mobile number';
                              }
                              if (value.startsWith('0')) {
                                return 'Do not start with 0; prefix covers it';
                              }
                              if (value.length < 7) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'A one-time PIN will be sent via sms on this number',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 32),
                  // Terms and Proceed
                  Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  'By tapping Proceed, you are accepting our ',
                            ),
                            TextSpan(
                              text: 'Terms & Conditions',
                              style: const TextStyle(
                                color: Color(0xFF2196C9),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer:
                                  null, // Add TapGestureRecognizer for real links
                            ),
                            const TextSpan(text: ' as well as our '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: const TextStyle(
                                color: Color(0xFF2196C9),
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7ED957),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: _proceed,
                          child: const Text(
                            'Proceed',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Bottom options
                  const Text(
                    "Don't have an Ecobank Account?",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF2196C9)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Open New Account',
                      style: TextStyle(
                        color: Color(0xFF2196C9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF2196C9)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Use Other Bank's Card",
                      style: TextStyle(
                        color: Color(0xFF2196C9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
