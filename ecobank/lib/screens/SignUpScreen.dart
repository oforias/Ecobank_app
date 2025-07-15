import 'package:flutter/material.dart';
import '../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Country list
  final List<Map<String, String>> countries = [
    {'name': 'Ghana', 'flag': 'assets/flags/gh.png', 'prefix': '+233'},
    {'name': 'Nigeria', 'flag': 'assets/flags/ng.png', 'prefix': '+234'},
    {'name': 'Ivory Coast', 'flag': 'assets/flags/ci.png', 'prefix': '+225'},
    {'name': 'Algeria', 'flag': 'assets/flags/dz.png', 'prefix': '+213'},
  ];
  int selectedCountryIndex = 0;

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigation(
            userName: _nameController.text.trim(),
            userPhone: _phoneController.text.trim(),
            userCountryCode: countries[selectedCountryIndex]['prefix']!,
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
                              'assets/flags/us.png', // US flag asset in main assets folder
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
                  const SizedBox(height: 48),
                  // Title
                  const Center(
                    child: Text(
                      'Create your Ecobank account',
                      style: TextStyle(
                        color: Color(0xFF2196C9),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
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
                  // Phone Number with flag and prefix picker
                  const Text(
                    'Phone Number',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        DropdownButton<int>(
                          value: selectedCountryIndex,
                          underline: const SizedBox(),
                          items: List.generate(countries.length, (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Row(
                                children: [
                                  Image.asset(
                                    countries[index]['flag']!,
                                    width: 24,
                                    height: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(countries[index]['prefix']!),
                                ],
                              ),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              selectedCountryIndex = value!;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(
                              hintText: 'Phone number',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password
                  const Text(
                    'Password',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  _PasswordField(hint: 'Enter your password'),
                  const SizedBox(height: 20),
                  // Confirm Password
                  const Text(
                    'Confirm Password',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  _PasswordField(hint: 'Re-enter your password'),
                  const SizedBox(height: 32),
                  // Sign Up button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF7ED957,
                        ), // Ecobank green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: _signUp,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Already have an account? Login link
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Already have an account? Login',
                        style: TextStyle(
                          color: Color(0xFF2196C9),
                          fontWeight: FontWeight.w600,
                        ),
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

class _PasswordField extends StatefulWidget {
  final String hint;
  const _PasswordField({required this.hint});

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscure,
      decoration: InputDecoration(
        hintText: widget.hint,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        ),
      ),
    );
  }
}
