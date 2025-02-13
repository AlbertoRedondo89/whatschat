import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajustes')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Notificaciones'),
            value: true,
            onChanged: (bool value) {},
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
