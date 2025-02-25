import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatschat/providers/apiprovider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _nombreController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _register() async {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    try {
      final response = await apiProvider.register({
        'USERNAME': _nombreController.text,
        'PASSWORD': _passwordController.text,
        'BIO': 'Hello, Im using WhatsChat!',
        'IMAGE':
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
      });

      final token = response['token'];
      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
      }

      print('Register successful: $response');

      // Volver a la pantalla de Login con los datos ya escritos
      Navigator.pop(context, {
        'username': _nombreController.text,
        'password': _passwordController.text
      });
    } catch (error) {
      print('Register failed: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Register failed: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Registro',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre de usuario', border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña', border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.secondary,
                foregroundColor: Colors.white,
              ),
              onPressed: _register,
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
