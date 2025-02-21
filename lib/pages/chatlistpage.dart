import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatschat/pages/chatpage.dart';
import 'package:whatschat/pages/profilepage.dart';
import 'package:whatschat/pages/settingspage.dart';
import 'package:whatschat/providers/themeprovider.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats')
      ),
      drawer: Drawer(
        child: Container(
          color: theme.scaffoldBackgroundColor, // 🔹 Fondo del menú lateral según el tema
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: theme.primaryColor, // 🔹 Color de fondo del header
                ),
                child: Text(
                  'Ajustes',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person, color: theme.iconTheme.color),
                title: Text('Perfil', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: theme.iconTheme.color),
                title: Text('Ajustes', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: theme.iconTheme.color),
                title: Text('Cerrar sesión', style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[900] : Colors.white, // 🔹 Color de fondo según el tema
                borderRadius: BorderRadius.circular(12),
                boxShadow: isDarkMode
                    ? []
                    : [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: CircleAvatar(backgroundColor: theme.colorScheme.primary),
                title: Text(
                  'Usuario $index',
                  style: TextStyle(color: theme.textTheme.bodyMedium?.color), // 🔹 Color del texto según el tema
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatPage(username: 'Usuario $index')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
