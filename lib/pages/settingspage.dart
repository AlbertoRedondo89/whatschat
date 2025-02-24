import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatschat/preferences/preferences.dart';
import 'package:whatschat/providers/themeprovider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color; 

    return Scaffold(
      appBar: AppBar(title: Text('Ajustes')),
      body: ListView(
        children: [
          // Notificaciones
          SwitchListTile(
            title: Text('Notificaciones', style: TextStyle(color: textColor)),
            value: Preferences.Notificaciones,
            onChanged: (bool value) {
              Preferences.Notificaciones = value;
            },
          ),

          // Campo para el nombre
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              initialValue: Preferences.nombre,
              onChanged: (value) {
                Preferences.nombre = value;
              },
              decoration: InputDecoration(
                labelText: 'Nombre', 
                helperText: 'Nombre del usuario'
              ),
            ),
          ),

          // Campo para la contraseña
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              initialValue: Preferences.password,
              onChanged: (value) {
                Preferences.password = value;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña', 
                helperText: 'Contraseña del usuario'
              ),
            ),
          ),

          Divider(),

          // Opciones adicionales
          ListTile(
            leading: Icon(Icons.lock, color: theme.iconTheme.color),
            title: Text('Cambiar contraseña', style: TextStyle(color: textColor)),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.language, color: theme.iconTheme.color),
            title: Text('Idioma', style: TextStyle(color: textColor)),
            onTap: () {},
          ),

          ListTile(
            leading: Icon(Icons.exit_to_app, color: theme.iconTheme.color),
            title: Text('Cerrar sesión', style: TextStyle(color: textColor)),
            onTap: () {},
          ),

          Divider(),

          // Modo oscuro con Provider y Preferences
          SwitchListTile(
            title: Text('Modo oscuro', style: TextStyle(color: textColor)),
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              Preferences.modoOscuro = value;
            },
          ),
        ],
      ),
    );
  }
}
