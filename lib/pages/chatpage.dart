import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/chat_message.dart';
import '../providers/apiprovider.dart';

class ChatPage extends StatefulWidget {
  final String username;
  final String user1;
  final String user2;

  ChatPage({required this.username, required this.user1, required this.user2});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessage> messages = [];
  late ApiProvider apiProvider;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    apiProvider = Provider.of<ApiProvider>(context, listen: false);
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    try {
      final response = await apiProvider.getUsersMessages(20, widget.user1, widget.user2);
      setState(() {
        messages = (response['messages'] as List).map((msg) => ChatMessage.fromJson(msg)).toList();
      });
    } catch (e) {
      print("Error fetching messages: $e");
    }
  }

  Future<void> sendMessage() async {
    if (_controller.text.isNotEmpty) {
      ChatMessage newMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch,
        senderId: int.parse(widget.user1),
        receiverId: int.parse(widget.user2),
        text: _controller.text,
        date: "Ahora",
      );

      setState(() {
        messages.add(newMessage);
      });

      _controller.clear();

      try {
        await apiProvider.sendMessage(newMessage.toJson());
      } catch (e) {
        print("Error sending message: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.username)),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(child: Text("No hay mensajes"))
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.senderId.toString() == widget.user1;

                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[300] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.text,
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(height: 5),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  message.date,
                                  style: TextStyle(color: Colors.black54, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Escribe un mensaje...",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}
