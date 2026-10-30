class ChatMessage {
  final String id;
  final String senderId;
  final String text;
  final String timestamp;
  final bool isFromHandyman;
  final bool isRead;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isFromHandyman,
    this.isRead = true,
  });
}