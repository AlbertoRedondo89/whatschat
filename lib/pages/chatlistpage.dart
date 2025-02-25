import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatschat/pages/chatpage.dart';
import 'package:whatschat/pages/profilepage.dart';
import 'package:whatschat/pages/settingspage.dart';
import 'package:whatschat/providers/apiprovider.dart';
import 'package:whatschat/providers/boton_grupos_provider.dart';
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
              children: [
                _buildChatList(context, isDarkMode), // 🔹 Lista de Chats
                _buildGroupList(context, isDarkMode),  // 🔹 Lista de Grupos
              ],
            ),
            floatingActionButton: Consumer<BotonGruposProvider>(
              builder: (context, tabProvider, child) {
                return tabProvider.currentIndex == 1
                    ? FloatingActionButton(
                        backgroundColor: theme.colorScheme.secondary,
                        child: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          print("Añadir grupo");
                        },
                      )
                    : SizedBox.shrink(); // 🔹 Oculta el botón si no está en "Grupos"
              },
            ),
          );
      ),
    );
  }

  Widget _buildChatList(BuildContext context, bool isDarkMode) {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    return FutureBuilder(
      future: apiProvider.getHome(),
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
          return Center(child: Text('No hay mensajes disponibles'));
        } else {
          final messages = snapshot.data['contacts'];


          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isGroup = message['isGroup'] ?? false;


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
                      message['username'],
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    subtitle: Text(message['message']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatPage(username: message['username'])),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildGroupList(BuildContext context, bool isDarkMode) {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);


    return FutureBuilder(
      future: apiProvider.getHome(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
          return Center(child: Text('No hay mensajes disponibles'));
        } else {
          final messages = snapshot.data['contacts'];


          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isGroup = message['isGroup'] ?? false;


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
                      message['username'],
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    subtitle: Text(message['message']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatPage(username: message['username'])),
                      );
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
