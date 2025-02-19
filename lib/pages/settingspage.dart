import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatschat/providers/themeprovider.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color; // 🔹 Obtener el color del texto según el tema

    return Scaffold(
      appBar: AppBar(title: Text('Ajustes')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Notificaciones', style: TextStyle(color: textColor)),
            value: true,
            onChanged: (bool value) {},
          ),
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
          SwitchListTile(
            title: Text('Modo oscuro', style: TextStyle(color: textColor)),
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
