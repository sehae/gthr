import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting timestamps
import '../../models/chat_message.dart';
import '../../services/database.dart';

class GroupPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String currentUserId;

  const GroupPage({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  late Stream<List<Chat>> _groupChatStream;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _groupChatStream = DatabaseService()
        .getGroupMessages(widget.groupId); // Retrieve messages for the group
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        backgroundColor: const Color(0xFF1E7251),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Chat>>(
              stream: _groupChatStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final groupMessages = snapshot.data ?? [];
                  if (groupMessages.isEmpty) {
                    return const Center(
                        child: Text('No messages in the group'));
                  }
                  return ListView.builder(
                    reverse: true, // Start from the latest messages
                    itemCount: groupMessages.length,
                    itemBuilder: (context, index) {
                      final groupMessage = groupMessages[index];
                      final isIncoming =
                          groupMessage.senderId != widget.currentUserId;

                      return _buildChatBubble(
                        text: groupMessage.message,
                        timestamp: groupMessage.timestamp,
                        isIncoming: isIncoming,
                      );
                    },
                  );
                }
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
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
            color: const Color(0xFF1E7251),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      final chat = Chat(
        chatId: widget.groupId, // Using the groupId for group messaging
        senderId: widget.currentUserId,
        receiverId: '', // No receiverId in group chat
        message: text,
        timestamp: DateTime.now(),
      );

      DatabaseService()
          .sendGroupMessage(widget.groupId, chat) // Use the new method
          .then((_) {
        _textController.clear(); // Clear the text field after sending
      }).catchError((error) {
        print('Error sending group message: $error');
      });
    }
  }

  Widget _buildChatBubble({
    required String text,
    required DateTime timestamp,
    required bool isIncoming,
  }) {
    final alignment = isIncoming ? Alignment.centerLeft : Alignment.centerRight;
    final outgoingColor = Color(0xFF6D9D8A);
    final incomingColor = Color(0xFFB5CFC5);

    final margin = isIncoming
        ? EdgeInsets.only(left: 20, right: 40, top: 10, bottom: 10)
        : EdgeInsets.only(right: 20, left: 40, top: 10, bottom: 10);

    return Container(
      margin: margin,
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isIncoming ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isIncoming ? incomingColor : outgoingColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isIncoming ? Colors.black : Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            DateFormat('hh:mm a').format(timestamp),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
