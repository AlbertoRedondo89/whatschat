import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatschat/preferences/preferences.dart';
import 'package:whatschat/providers/apiprovider.dart';

class ChatPage extends StatefulWidget {
  final String username;
  final String icon;

  ChatPage({required this.username, required this.icon});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.icon != "null"
                  ? NetworkImage(widget.icon)
                  : AssetImage('assets/images/user_avatar.png') as ImageProvider,
            ),
            SizedBox(width: 10),
            Text(widget.username),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/chat_background.jpg"),
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: apiProvider.getUsersMessages(50, Preferences.nombre, widget.username),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                    return Center(child: Text('No hay mensajes disponibles'));
                  } else {
                    final response = snapshot.data as Map<String, dynamic>;
                    final messages = response['messages'] as List<dynamic>;

                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final sender = message['username'] ?? '';
                        final text = message['body'] ?? '';
                        final isCurrentUser = sender == Preferences.nombre;

                        return ListTile(
                          title: Align(
                            alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isCurrentUser ? Colors.blue : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                text,
                                style: TextStyle(color: isCurrentUser ? Colors.white : Colors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Escribe un mensaje...',
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      if (_messageController.text.isNotEmpty) {
                        final message = {
                          'sender': Preferences.nombre,
                          'receiver': widget.username,
                          'body': _messageController.text,
                        };

                        await apiProvider.sendMessage(message);

                        setState(() {
                          _messageController.clear();
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}