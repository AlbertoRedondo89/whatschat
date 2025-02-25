import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatschat/pages/chatlistpage.dart';
import 'package:whatschat/pages/register_page.dart';
import 'package:whatschat/providers/apiprovider.dart';
import 'package:whatschat/providers/preferencesprovider.dart';
import 'package:whatschat/preferences/preferences.dart';

// Página de login.
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _nombreController;
  late TextEditingController _passwordController;
  late bool _rememberMe;

  // Inicializa el estado de la página de login.
  @override
  void initState() {
    super.initState();
    _rememberMe = Preferences.rememberMe;
    _nombreController = TextEditingController(text: _rememberMe ? Preferences.nombre : "");
    _passwordController = TextEditingController(text: _rememberMe ? Preferences.password : "");
  }

  // Método para hacer login.
  void _login() async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    try {
      final response = await apiProvider.login(_nombreController.text, _passwordController.text);
      final token = response['token'];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatListPage()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login failed: $error')));
    }
  }

  // Método para registrar un usuario.
  void _register() async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    try {
      final response = await apiProvider.register({
        'USERNAME': _nombreController.text,
        'PASSWORD': _passwordController.text,
        'BIO': 'Hello, Im using WhatsChat!',
        'IMAGE': 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      });
      final token = response['token'];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatListPage()));
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register failed: $error')));
    }
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
            TextFormField(
              controller: _nombreController,
              onChanged: (value) => Preferences.nombre = value,
              decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              onChanged: (value) => Preferences.password = value,
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
              style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.secondary, foregroundColor: Colors.white),
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            Text('Not a member?'),
            TextButton(
              onPressed: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));
                if (result != null) {
                  setState(() {
                    _nombreController.text = result['username'] ?? "";
                    _passwordController.text = result['password'] ?? "";
                  });
                }
              },
              child: Text('Register', style: TextStyle(color: theme.colorScheme.secondary)),
            ),
          ],
        ),
      ),
    );
  }
}

