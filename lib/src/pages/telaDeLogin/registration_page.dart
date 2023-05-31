import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _showPassword = false;
  bool _enableEmailNotifications = false;
  bool _enablePhoneNotifications = false;
  String _selectedGender = '';
  double _fontSize = 16.0;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    final String name = _nameController.text.trim();
    final String dob = _dobController.text.trim();
    final String phone = _phoneController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // Save registration data using SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('dob', dob);
    await prefs.setString('phone', phone);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }


  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _onGenderSelected(String value) {
    setState(() {
      _selectedGender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              maxLength: 50,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _dobController,
              decoration: const InputDecoration(labelText: 'Date of Birth'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
              maxLength: 10,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              obscureText: !_showPassword,
            ),
            const SizedBox(height: 16.0),
            CheckboxListTile(
              title: const Text('Male'),
              value: _selectedGender == 'Male',
              onChanged: (value) => _onGenderSelected('Male'),
            ),
            CheckboxListTile(
              title: const Text('Female'),
              value: _selectedGender == 'Female',
              onChanged: (value) => _onGenderSelected('Female'),
            ),
            const SizedBox(height: 16.0),
            SwitchListTile(
              title: const Text('Enable Email Notifications'),
              value: _enableEmailNotifications,
              onChanged: (value) {
                setState(() {
                  _enableEmailNotifications = value;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Enable Phone Notifications'),
              value: _enablePhoneNotifications,
              onChanged: (value) {
                setState(() {
                  _enablePhoneNotifications = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Slider(
              value: _fontSize,
              min: 10.0,
              max: 24.0,
              divisions: 7,
              label: _fontSize.round().toString(),
              onChanged: (value) {
                setState(() {
                  _fontSize = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              style: TextStyle(fontSize: _fontSize),
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Fonte variável',
                labelStyle: TextStyle(fontSize: _fontSize),
              ),
              maxLength: 50,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                 _register();
                // Perform registration logic here
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
