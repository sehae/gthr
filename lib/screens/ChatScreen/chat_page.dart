import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_list.dart';
import '../../models/user.dart';
import '../../services/database.dart';
import 'package:gthr/models/chat_message.dart';

class ChatScreen extends StatefulWidget {
  final UserList chatPartner; // The chat partner
  final myUser currentUser; // The logged-in user

  const ChatScreen({
    super.key,
    required this.chatPartner,
    required this.currentUser,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late DatabaseService _databaseService;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check if currentUser and chatPartner have valid UIDs
    if (widget.currentUser.uid == null || widget.chatPartner.uid == null) {
      throw Exception("Both currentUserId and chatPartnerId must be defined");
    }

    // Initialize DatabaseService with valid UIDs
    _databaseService = DatabaseService(
      currentUserId: widget.currentUser.uid,
      chatPartnerId: widget.chatPartner.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.chatPartner.fname} ${widget.chatPartner.lname}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessagesStream(), // Messages stream
          ),
          _buildMessageInput(), // Input for new messages
        ],
      ),
    );
  }

  Widget _buildMessagesStream() {
    return StreamBuilder<List<ChatMessage>>(
      stream: _databaseService.messagesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final messages = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return _buildChatBubble(messages[index]);
            },
          );
        } else {
          return const Center(child: Text('No messages found'));
        }
      },
    );
  }

  // Build the chat bubble depending on outgoing or incoming messages
  Widget _buildChatBubble(ChatMessage message) {
    final isOutgoing =
        message.senderId == widget.currentUser.uid; // Outgoing or incoming

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isOutgoing ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isOutgoing
                  ? Colors.green
                  : Colors.grey[300], // Outgoing vs incoming
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: isOutgoing ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 5), // Space between bubble and timestamp
          Text(
            DateFormat('hh:mm a').format(message.timestamp ?? DateTime.now()),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // Input field for sending messages
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      _databaseService.sendMessage(text); // Send message
      _textController.clear(); // Clear the text field
    }
  }
}
