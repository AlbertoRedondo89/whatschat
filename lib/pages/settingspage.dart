import 'package:flutter/material.dart';
import 'package:whatschat/preferences/preferences.dart';

class SettingsPage extends StatefulWidget {
  static const String routerName = 'settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends  State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ajustes')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Notificaciones'),
            value: Preferences.Notificaciones,
            onChanged: (value) {
              Preferences.Notificaciones = value;
              setState(() {});
            },
            
          ),
          TextFormField(
            initialValue: Preferences.nombre,
            onChanged: (value) {
              Preferences.nombre = value;
              setState(() {});
            },
            decoration: InputDecoration(
            labelText: 'Nombre', helperText: 'Nombre del usuario'),
          ),
          TextFormField(
            initialValue: Preferences.password,
            onChanged: (value) {
              Preferences.password = value;
              setState(() {});
            },
            decoration: InputDecoration(
            labelText: 'Contraseña', helperText: 'Contraseña del usuario'),
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
