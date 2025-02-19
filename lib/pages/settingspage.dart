import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  bool value = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajustes')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Notificaciones'),
            value: value,
            onChanged: (value) {value = !value;},
          ),
          ListTile(
            title: Text('Cambiar contraseña'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Idioma'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Cerrar sesión'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
