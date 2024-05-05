// front pa lang i2 pls don't kill me huhubells
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

  @override
  void initState() {
    super.initState();
    print('ChatScreen user: ${widget.user.toString()}');
    _chatStream = DatabaseService().getMessages(widget.currentUserId, widget.user.uid!);
    _chatStream.listen((chatMessages) {
      chatMessages.forEach((chatMessage) {
        print('Chat message: ${chatMessage.message}');
      });
    });
  }

  final TextEditingController _textController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.user.fname} ${widget.user.lname}'),
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
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  final chatMessages = snapshot.data!;
                  return ListView.builder(
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) {
                      final chatMessage = chatMessages[index];
                      // Determine if the message is incoming
                      bool isIncoming = chatMessage.senderId != widget.currentUserId;
                      // Create a _ChatMessage object
                      _ChatMessage _chatMessage = _ChatMessage(
                        text: chatMessage.message,
                        timestamp: chatMessage.timestamp,
                        isIncoming: isIncoming,
                      );
                      // Build a chat bubble for the chat message
                      return _buildChatBubble(_chatMessage);
                    },
                  );
                } else {
                  return Container(); // Return an empty container when there are no messages
                }
              },
            ),
          ),
          _buildMessageInput(), // Always show the message input field
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
  // Function to send a message
  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      if (widget.user.uid == null) {
        print('Error: user uid is null');
        return;
      }

      // Generate a chatId
      final chatId = '${widget.currentUserId}_${widget.user.uid!}';

      // Create a new Chat object with the message details
      final message = Chat(
        chatId: chatId,
        senderId: widget.currentUserId,
        receiverId: widget.user.uid!,
        message: text,
        timestamp: DateTime.now(),
      );

      // Print the chatId and message for debugging
      print('chatId: $chatId');
      print('message: ${message.message}');

      // Send the message using the DatabaseService
      DatabaseService().sendMessage(chatId, message);

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
                  ? const Color(0xFF6D9D8A)
                  : const Color(
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
