import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _conversations = [
    {
      'id': '1',
      'name': 'Juan Pérez',
      'lastMessage': '¿Tienes la carta Blue-Eyes?',
      'timestamp': '10:30 AM',
      'unread': 2,
      'avatar': 'https://via.placeholder.com/50x50/CCCCCC/FFFFFF?text=JP',
    },
    {
      'id': '2',
      'name': 'María García',
      'lastMessage': 'Perfecto, me interesa el Charizard',
      'timestamp': '9:15 AM',
      'unread': 0,
      'avatar': 'https://via.placeholder.com/50x50/CCCCCC/FFFFFF?text=MG',
    },
    {
      'id': '3',
      'name': 'Carlos López',
      'lastMessage': '¿Cuál es el precio mínimo?',
      'timestamp': 'Ayer',
      'unread': 1,
      'avatar': 'https://via.placeholder.com/50x50/CCCCCC/FFFFFF?text=CL',
    },
  ];

  final List<Map<String, dynamic>> _messages = [
    {
      'id': '1',
      'sender': 'Juan Pérez',
      'message': 'Hola, ¿tienes la carta Blue-Eyes White Dragon?',
      'timestamp': '10:30 AM',
      'isMe': false,
    },
    {
      'id': '2',
      'sender': 'Tú',
      'message': 'Sí, la tengo disponible. ¿Te interesa?',
      'timestamp': '10:32 AM',
      'isMe': true,
    },
    {
      'id': '3',
      'sender': 'Juan Pérez',
      'message': '¿Cuál es el precio?',
      'timestamp': '10:33 AM',
      'isMe': false,
    },
    {
      'id': '4',
      'sender': 'Tú',
      'message': 'Está en \$25.99, en excelente estado',
      'timestamp': '10:35 AM',
      'isMe': true,
    },
  ];

  bool _showChat = false;
  String? _selectedConversation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          _showChat ? 'Juan Pérez' : 'Mensajes',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        leading: _showChat
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () {
                  setState(() {
                    _showChat = false;
                    _selectedConversation = null;
                  });
                },
              )
            : null,
        actions: [
          if (!_showChat)
            IconButton(
              icon: Icon(Icons.search, color: AppColors.textPrimary),
              onPressed: () {},
            ),
        ],
      ),
      body: _showChat ? _buildChatView() : _buildConversationsList(),
    );
  }

  Widget _buildConversationsList() {
    return ListView.builder(
      padding: EdgeInsets.all(AppSpacing.md),
      itemCount: _conversations.length,
      itemBuilder: (context, index) {
        final conversation = _conversations[index];
        return Card(
          margin: EdgeInsets.only(bottom: AppSpacing.sm),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(conversation['avatar']),
              radius: 25,
            ),
            title: Text(
              conversation['name'],
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              conversation['lastMessage'],
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  conversation['timestamp'],
                  style: AppTypography.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                if (conversation['unread'] > 0) ...[
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${conversation['unread']}',
                      style: AppTypography.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            onTap: () {
              setState(() {
                _showChat = true;
                _selectedConversation = conversation['id'];
              });
            },
          ),
        );
      },
    );
  }

  Widget _buildChatView() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(AppSpacing.md),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return _buildMessageBubble(message);
            },
          ),
        ),
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'] as bool;
    
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/50x50/4A90E2/FFFFFF?text=JP'),
              radius: 15,
            ),
            SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.grey100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message['message'],
                    style: AppTypography.bodyMedium.copyWith(
                      color: isMe ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    message['timestamp'],
                    style: AppTypography.caption.copyWith(
                      color: isMe ? Colors.white70 : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[
            SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/50x50/28A745/FFFFFF?text=YO'),
              radius: 15,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Escribe un mensaje...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: AppColors.grey300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: AppColors.grey300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            SizedBox(width: 8),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add({
          'id': DateTime.now().toString(),
          'sender': 'Tú',
          'message': _messageController.text.trim(),
          'timestamp': 'Ahora',
          'isMe': true,
        });
      });
      _messageController.clear();
    }
  }
}

