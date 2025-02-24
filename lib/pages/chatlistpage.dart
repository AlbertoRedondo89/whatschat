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

    return DefaultTabController(
      length: 2, // 🔹 Dos pestañas (Chats y Grupos)
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          bottom: TabBar(
            indicatorColor: theme.colorScheme.secondary, // 🔹 Color del indicador
            labelColor: theme.colorScheme.secondary, // 🔹 Color del icono y texto seleccionado
            unselectedLabelColor: Colors.grey, // 🔹 Color del icono y texto NO seleccionado
            tabs: [
              Tab(icon: Icon(Icons.chat), text: "Chats"),
              Tab(icon: Icon(Icons.group), text: "Grupos"),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: theme.scaffoldBackgroundColor,
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: theme.primaryColor),
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
        body: TabBarView(
          children: [
            _buildChatList(context, isDarkMode, false), // 🔹 Lista de chats normales
            _buildChatList(context, isDarkMode, true),  // 🔹 Lista de grupos
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 🔹 Aquí puedes abrir la pantalla para crear un grupo
            print("Crear grupo");
          },
          backgroundColor: theme.primaryColor,
          child: Icon(Icons.add, color: theme.iconTheme.color),
        ),
      ),
    );
  }

  Widget _buildChatList(BuildContext context, bool isDarkMode, bool isGroup) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey[900] : Colors.white,
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
              leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primary),
              title: Text(
                isGroup ? 'Grupo $index' : 'Usuario $index',
                style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage(username: isGroup ? 'Grupo $index' : 'Usuario $index')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
