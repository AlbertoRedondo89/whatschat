import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatschat/pages/chatlistpage.dart';
import 'package:whatschat/providers/preferencesprovider.dart';
import 'package:whatschat/preferences/preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _nombreController;
  late TextEditingController _passwordController;
  late bool _rememberMe;

  @override
  void initState() {
    super.initState();
    _rememberMe = Preferences.rememberMe;  // 🔹 Cargar estado de "Recuérdame"
    _nombreController = TextEditingController(text: _rememberMe ? Preferences.nombre : "");
    _passwordController = TextEditingController(text: _rememberMe ? Preferences.password : "");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final prefsProvider = Provider.of<PreferencesProvider>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png', height: 100),
            SizedBox(height: 20),
            Text('Sign In', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            SwitchListTile(
              title: Text("Recuérdame"),
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                  prefsProvider.rememberMe = value;
                  if (!value) {
                    Preferences.nombre = "";
                    Preferences.password = "";
                  }
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (_rememberMe) {
                  Preferences.nombre = _nombreController.text;
                  Preferences.password = _passwordController.text;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatListPage()),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Text('Not a member?'),
            TextButton(
              onPressed: () {},
              child: Text(
                'Register',
                style: TextStyle(color: theme.colorScheme.secondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
