// front pa lang i2 pls don't kill me huhubells
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting timestamps
import '../../models/user_list.dart';

class ChatScreen extends StatefulWidget {
  final UserList user; // The person being chatted with
  const ChatScreen({super.key, required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_ChatMessage> _messages = [
    // Example messages
    _ChatMessage(
        text: 'Hello!',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
        isIncoming: true),
    _ChatMessage(
        text: 'Hey, how are you?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
        isIncoming: false),
  ];

  final TextEditingController _textController =
      TextEditingController(); // Controller for text input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.user.fname} ${widget.user.lname}', // Display user's name
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E7251), // Consistent color scheme
      ),
      body: Column(
        children: [
          // Display chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildChatBubble(message);
              },
            ),
          ),
          // Text input for sending messages
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
              controller:
                  _textController, // Use the controller for the text input
              decoration: const InputDecoration(
                hintText: 'Type your message...',
                hintStyle: TextStyle(
                  color: Colors.grey, // Hint text color
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: _sendMessage, // Call the send message function
            icon: const Icon(Icons.send),
            color: const Color(0xFF1E7251),
          ),
        ],
      ),
    );
  }

  // Function to send a message
  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(_ChatMessage(
            text: text,
            timestamp: DateTime.now(),
            isIncoming: false)); // Outgoing message
      });
      _textController.clear(); // Clear the text input
    }
  }

  // Build a chat bubble based on whether the message is incoming or outgoing
  Widget _buildChatBubble(_ChatMessage message) {
    final isOutgoing = !message.isIncoming; // Check if the message is outgoing

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      alignment: isOutgoing
          ? Alignment.centerRight
          : Alignment.centerLeft, // Align left or right
      child: Column(
        crossAxisAlignment: isOutgoing
            ? CrossAxisAlignment.end
            : CrossAxisAlignment
                .start, // Align the timestamp to the correct side
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isOutgoing
                  ? Color(0xFF6D9D8A)
                  : Color(
                      0xFFB5CFC5), // Different colors for outgoing and incoming
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: isOutgoing
                    ? Colors.white
                    : Colors.black, // Different text colors
              ),
            ),
          ),
          const SizedBox(
              height: 5), // Space between the bubble and the timestamp
          Text(
            DateFormat('hh:mm a')
                .format(message.timestamp), // Format the timestamp
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey, // Color for the timestamp
            ),
          ),
        ],
      ),
    );
  }
}

// Class representing a chat message with text, a timestamp, and a flag indicating if it's incoming or outgoing
class _ChatMessage {
  final String text;
  final DateTime timestamp;
  final bool isIncoming; // Whether the message is incoming (from another user)

  _ChatMessage({
    required this.text,
    required this.timestamp,
    this.isIncoming = false, // Default to outgoing unless specified otherwise
  });
}
