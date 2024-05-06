import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting timestamps
import '../../models/chat_message.dart';
import '../../models/user_list.dart';
import '../../services/database.dart';

class ChatScreen extends StatefulWidget {
  final UserList user;
  final String currentUserId;

  const ChatScreen({
    Key? key,
    required this.user,
    required this.currentUserId,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Stream<List<Chat>> _chatStream;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final otherUserId = widget.user.uid;
    final currentUserId = widget.currentUserId;

    if (otherUserId == null) {
      print('Error: Other user ID is null');
      return;
    }

    final chatId1 = '${currentUserId}_${otherUserId}';
    final chatId2 = '${otherUserId}_${currentUserId}';

    _chatStream =
        DatabaseService(uid: currentUserId).getAllMessages([chatId1, chatId2]);
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
        title: Text('${widget.user.fname} ${widget.user.lname}'),
        backgroundColor: const Color(0xFF1E7251),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Chat>>(
              stream: _chatStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final chatMessages = snapshot.data ?? [];
                  if (chatMessages.isEmpty) {
                    return const Center(child: Text('No messages yet'));
                  }
                  return ListView.builder(
                    reverse: true, // Start from the bottom (latest messages)
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) {
                      final chatMessage = chatMessages[index];
                      final isIncoming =
                          chatMessage.senderId != widget.currentUserId;

                      return _buildChatBubble(
                        text: chatMessage.message,
                        timestamp: chatMessage.timestamp,
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
      final otherUserId = widget.user.uid;

      if (otherUserId == null) {
        print('Error: User UID is null');
        return;
      }

      final chatId = '${widget.currentUserId}_${otherUserId}';

      final message = Chat(
        chatId: chatId,
        senderId: widget.currentUserId,
        receiverId: otherUserId,
        message: text,
        timestamp: DateTime.now(),
      );

      DatabaseService().sendMessage(chatId, message).then((_) {
        _textController.clear();
      }).catchError((error) {
        print('Error sending message: $error');
      });
    }
  }

  Widget _buildChatBubble({
    required String text,
    required DateTime timestamp,
    required bool isIncoming,
  }) {
    final alignment = isIncoming ? Alignment.centerLeft : Alignment.centerRight;

    // Define the colors for incoming and outgoing messages
    final outgoingColor = Color(0xFF6D9D8A);
    final incomingColor = Color(0xFFB5CFC5);

    // Define the outer margin for spacing
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
