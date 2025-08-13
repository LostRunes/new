import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  final String name;
  final String avatar;

  const ChatPage({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      messages.add({"text": _controller.text.trim(), "isMe": true});
    });

    final userMessage = _controller.text.trim();
    _controller.clear();

    setState(() => _isLoading = true);

    // Simple free "AI" API
    try {
      final res = await http.get(Uri.parse("https://api.adviceslip.com/advice"));
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        final reply = data['slip']['advice'] ?? "Hmm, I have no advice right now.";
        setState(() {
          messages.add({"text": reply, "isMe": false});
        });
      } else {
        setState(() {
          messages.add({"text": "Sorry, I couldn't fetch a reply.", "isMe": false});
        });
      }
    } catch (e) {
      setState(() {
        messages.add({"text": "Error: $e", "isMe": false});
      });
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(widget.avatar)),
            const SizedBox(width: 8),
            Text(widget.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment:
                      msg["isMe"] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: msg["isMe"] ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(msg["text"]),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
