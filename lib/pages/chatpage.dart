import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String username;

  ChatPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage('assets/user_avatar.png')),
            SizedBox(width: 10),
            Text(username),
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
            Expanded(child: ListView()),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Escribe un mensaje...', 
                                                  fillColor: Colors.white, 
                                                  filled: true, 
                                                  border: OutlineInputBorder(),
                                                  ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {},
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