import 'package:flutter/material.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UserRepository {
  String firstName = '';
  String lastName = '';
  String phone = '';
  String email = '';

  final _prefs = EncryptedSharedPreferences();

  Future<void> loadData() async {
    try {
      firstName = await _prefs.getString('firstName');
      lastName = await _prefs.getString('lastName');
      phone = await _prefs.getString('phone');
      email = await _prefs.getString('email');
    } catch (_) {
      // If keys don't exist yet, do nothing
    }
  }

  Future<void> saveData() async {
    await _prefs.setString('firstName', firstName);
    await _prefs.setString('lastName', lastName);
    await _prefs.setString('phone', phone);
    await _prefs.setString('email', email);
  }
}

// Shared repository instance
final userRepo = UserRepository();

class ProfilePage extends StatefulWidget {
  final String loginName;

  const ProfilePage({super.key, required this.loginName});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userRepo.loadData().then((_) {
      setState(() {
        _fnameController.text = userRepo.firstName;
        _lnameController.text = userRepo.lastName;
        _phoneController.text = userRepo.phone;
        _emailController.text = userRepo.email;
      });
    });

    _fnameController.addListener(() {
      userRepo.firstName = _fnameController.text;
      userRepo.saveData();
    });
    _lnameController.addListener(() {
      userRepo.lastName = _lnameController.text;
      userRepo.saveData();
    });
    _phoneController.addListener(() {
      userRepo.phone = _phoneController.text;
      userRepo.saveData();
    });
    _emailController.addListener(() {
      userRepo.email = _emailController.text;
      userRepo.saveData();
    });
  }

  void _launch(String scheme) async {
    final uri = Uri.parse(scheme);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Not Supported"),
          content: const Text("This action is not supported on your device."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Back ${widget.loginName}")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _fnameController,
              decoration: const InputDecoration(labelText: "First Name"),
            ),
            TextField(
              controller: _lnameController,
              decoration: const InputDecoration(labelText: "Last Name"),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: "Phone Number"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () => _launch("tel:${_phoneController.text}"),
                ),
                IconButton(
                  icon: const Icon(Icons.message),
                  onPressed: () => _launch("sms:${_phoneController.text}"),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: "Email address"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mail),
                  onPressed: () => _launch("mailto:${_emailController.text}"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
