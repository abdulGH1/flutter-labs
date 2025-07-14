//lab 4

import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  final _prefs = EncryptedSharedPreferences();

  String imageSource = "images/question-mark.png";

  @override
  void initState() {
    super.initState();
    _loadLoginData();
  }

  Future<void> _loadLoginData() async {
    try {
      String login = await _prefs.getString('login');
      String password = await _prefs.getString('password');

      setState(() {
        _loginController.text = login;
        _passwordController.text = password;
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Encrypted login and password loaded")),
        );
      });
    } catch (e) {
      // Do nothing if keys don't exist
    }
  }

  Future<void> _saveLoginData() async {
    await _prefs.setString('login', _loginController.text);
    await _prefs.setString('password', _passwordController.text);
  }

  Future<void> _clearLoginData() async {
    await _prefs.remove('login');
    await _prefs.remove('password');
  }

  void _handleLogin() {
    final password = _passwordController.text;

    setState(() {
      imageSource = password == "QWERTY123"
          ? "images/idea.png"
          : password.isEmpty
          ? "images/question-mark.png"
          : "images/stop.png";
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Save Login?"),
        content: const Text("Would you like to securely save your login info?"),
        actions: [
          TextButton(
            child: const Text("Yes"),
            onPressed: () {
              _saveLoginData();
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text("No"),
            onPressed: () {
              _clearLoginData();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Encrypted Login Page"),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextField(
                controller: _loginController,
                decoration: const InputDecoration(
                  labelText: "Login",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),
              Image.asset(
                imageSource,
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
