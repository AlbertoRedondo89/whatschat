import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatschat/pages/chatpage.dart';
import 'package:whatschat/pages/profilepage.dart';
import 'package:whatschat/pages/settingspage.dart';
import 'package:whatschat/providers/boton_grupos_provider.dart';
import 'package:whatschat/providers/themeprovider.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final botonProvider = Provider.of<BotonGruposProvider>(context); // 🔹 Accede al índice de la pestaña

    return DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context)!;
          
          // 🔹 Detecta cuando cambia la pestaña (tap o swipe)
          tabController.addListener(() {
            if (!tabController.indexIsChanging) { // 🔹 Solo cuando realmente cambió
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
                _buildChatList(context, isDarkMode, false), // 🔹 Lista de Chats
                _buildChatList(context, isDarkMode,true),  // 🔹 Lista de Grupos
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
        },
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
