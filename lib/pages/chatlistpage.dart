import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/chatpage.dart';
import '../providers/apiprovider.dart';
import '../models/home_model.dart'; // Para la lista de contactos

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  late ApiProvider apiProvider;
  List<Contact> chats = [];
  List<Contact> groups = [];

  @override
  void initState() {
    super.initState();
    apiProvider = Provider.of<ApiProvider>(context, listen: false);
    fetchChatsAndGroups();
  }

  Future<void> fetchChatsAndGroups() async {
    try {
      final homeData = await apiProvider.getHome();
      setState(() {
        chats = homeData["contacts"].map<Contact>((data) => Contact.fromMap(data)).toList();
        groups = homeData["groups"].map<Contact>((data) => Contact.fromMap(data)).toList();
      });
    } catch (e) {
      print("Error al obtener los chats y grupos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chats'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.chat), text: "Chats"),
              Tab(icon: Icon(Icons.group), text: "Grupos"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildChatList(context, theme, chats, false),
            _buildChatList(context, theme, groups, true),
          ],
        ),
      ),
    );
  }

  Widget _buildChatList(BuildContext context, ThemeData theme, List<Contact> list, bool isGroup) {
    if (list.isEmpty) {
      return Center(child: Text(isGroup ? "No hay grupos" : "No hay chats"));
    }

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final contact = list[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
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
                backgroundImage: NetworkImage(contact.imageUrl),
                backgroundColor: theme.colorScheme.primary,
              ),
              title: Text(
                contact.username,
                style: TextStyle(color: theme.textTheme.bodyMedium?.color),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      username: contact.username,
                      user1: "<ID_DEL_USUARIO_ACTUAL>", // ⚠️ REEMPLAZA CON EL ID REAL DEL USUARIO
                      user2: "<ID_DEL_CONTACTO>", // ⚠️ REEMPLAZA CON EL ID REAL DEL CONTACTO O GRUPO
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
}
