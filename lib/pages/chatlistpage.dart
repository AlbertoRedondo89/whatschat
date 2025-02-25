import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatschat/pages/chatpage.dart';
import 'package:whatschat/pages/profilepage.dart';
import 'package:whatschat/pages/settingspage.dart';
import 'package:whatschat/preferences/preferences.dart';
import 'package:whatschat/providers/apiprovider.dart';
import 'package:whatschat/providers/boton_grupos_provider.dart';
import 'package:whatschat/providers/themeprovider.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final botonProvider = Provider.of<BotonGruposProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context)!;
          
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              botonProvider.setIndex(tabController.index);
            }
          });

          return Scaffold(
            appBar: AppBar(
              title: Text('Chats'),
              bottom: TabBar(
                controller: tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(icon: Icon(Icons.chat), text: "Chats"),
                  Tab(icon: Icon(Icons.group), text: "Grupos"),
                ],
              ),
            ),
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(color: theme.primaryColor),
                    child: Text('Ajustes', style: TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Perfil'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Ajustes'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage())),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: [
                _buildChatList(context, isDarkMode), // Lista de chats normales
                Center(child: Text('No hay grupos disponibles')), // Sección de grupos vacía
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showNewChatModal(context),
              child: Icon(Icons.add),
              backgroundColor: theme.primaryColor,
            ),
          );
        }
      ),
    );
  }

  // Método para construir la lista de chats
  Widget _buildChatList(BuildContext context, bool isDarkMode) {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    return FutureBuilder(
      future: apiProvider.getHome(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras se obtienen los datos
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Muestra un mensaje de error si ocurre un error
        } else if (!snapshot.hasData || snapshot.data.isEmpty) {
          return Center(child: Text('No hay mensajes disponibles')); // Muestra un mensaje si no hay datos disponibles
        } else {
          final messages = snapshot.data['contacts']; // Obtiene la lista de contactos

          return ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final bool messageIsGroup = message['isGroup'] ?? false;
              if (messageIsGroup) return SizedBox.shrink(); // Oculta los mensajes de grupo

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
                    leading: CircleAvatar(
                      backgroundImage: message['image'] != null
                          ? NetworkImage(message['image'])
                          : AssetImage('assets/images/user_avatar.png') as ImageProvider,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      message['username'] + '\t' + message['time'],
                      style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),
                    ),
                    subtitle: Text(message['message']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            username: message['username'],
                            icon: message['image'] != null ? message['image'] : 'null',
                          ),
                        ),
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

  // Método para mostrar el modal de nuevo chat
  void _showNewChatModal(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _messageController = TextEditingController();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nuevo Chat'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nombre de receptor'),
              ),
              TextFormField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'Mensaje'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el modal sin hacer nada
              },
            ),
            TextButton(
              child: Text('Enviar'),
              onPressed: () async {
                if (_usernameController.text.isNotEmpty && _messageController.text.isNotEmpty) {
                  final message = {
                    'sender': Preferences.nombre,
                    'receiver': _usernameController.text,
                    'body': _messageController.text,
                  };

                  await apiProvider.sendMessage(message); // Envía el mensaje

                  Navigator.of(context).pop(); // Cierra el modal después de enviar el mensaje
                }
              },
            ),
          ],
        );
      },
    );
  }
}