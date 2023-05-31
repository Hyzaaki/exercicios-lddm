import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:exercicios/src/pages/telaDeLogin/registration_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _showPassword = false;

  void _login() {
    final String email = _loginController.text.trim();
    final String password = _passwordController.text.trim();

    if (email == 'eu@gmail.com' && password == '1234') {
      const AlertDialog(content: Text('Login Efetivado'));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid data'),
            content: const Text('Incorrect username and/or password'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _loginVerify() async {
    final String email = _loginController.text.trim();
    final String password = _passwordController.text.trim();

    // Read registration data from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? registeredEmail = prefs.getString('email');
    final String? registeredPassword = prefs.getString('password');

    if (email == registeredEmail && password == registeredPassword) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Realizado")));
    } else {
      // Credentials are incorrect, display an AlertDialog
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid data'),
            content: const Text('Incorrect username and/or password'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _navigateRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const RegistrationScreen();
        },
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _loginController,
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
            ElevatedButton(
              onPressed: () async {
                _login();
                _loginVerify();
                // Perform registration logic here
              },
              child: const Text('LOGIN'),
            ),
            GestureDetector(
              onTap: _navigateRegistration,
              child: const Text("Don't have an Account?",
                  style: TextStyle(color: Colors.lightBlue)),
            ),
          ],
        ),
      ),
    );
  }
}
