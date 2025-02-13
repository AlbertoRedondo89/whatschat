import 'package:flutter/material.dart';
import 'package:whatschat/pages/chatpage.dart';
import 'package:whatschat/pages/profilepage.dart';
import 'package:whatschat/pages/settingspage.dart';

class ChatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chats')),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('Menú')),
            ListTile(title: Text('Perfil'), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            }),
            ListTile(title: Text('Ajustes'), onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            }),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: CircleAvatar(),
                title: Text('Usuario $index'),
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