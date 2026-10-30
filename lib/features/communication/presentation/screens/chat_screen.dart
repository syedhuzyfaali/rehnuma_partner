import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_header_bar.dart';
import '../../../jobs/presentation/controllers/job_controller.dart';
import '../../domain/chat_message_model.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String jobId;

  const ChatScreen({super.key, required this.jobId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _messageCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageCtrl.text.trim();
    if (text.isEmpty) return;
    ref.read(chatMessagesProvider.notifier).sendMessage(text);
    _messageCtrl.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);

    return Scaffold(
      backgroundColor: AppColors.headerBlue,
      body: Column(
        children: [
          AppHeaderBar(
            showBackButton: true,
            onBackPress: () => context.pop(),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.surfaceWhite,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                child: Column(
                  children: [
                    // Client Contact Banner
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE5F1FC),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                "MB",
                                style: AppTextStyles.labelSemibold.copyWith(
                                  color: AppColors.primaryBlue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Maryam Bibi", style: AppTextStyles.itemTitle.copyWith(fontSize: 18)),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.statusGreen,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Online · Client",
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondaryGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => context.push('/jobs/${widget.jobId}/call'),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDF6FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.phone_outlined, size: 22, color: AppColors.primaryBlue),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Job Reference Sub-bar
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF6FF),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Leaking kitchen tap", style: AppTextStyles.labelSemibold.copyWith(fontSize: 14)),
                              const SizedBox(height: 2),
                              Text(
                                "Ayesha Khan · Request #${widget.jobId}",
                                style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryBlue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Date Separator
                    Text("Today, 20 Oct 2026", style: AppTextStyles.bodySmall),
                    const SizedBox(height: 10),

                    // Messages Scroll Area
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollCtrl,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final msg = messages[index];
                          return _buildMessageItem(msg);
                        },
                      ),
                    ),

                    // Bottom Input Area
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: MediaQuery.of(context).padding.bottom + 8,
                        top: 8,
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceWhite,
                              borderRadius: BorderRadius.circular(26),
                              border: Border.all(color: AppColors.borderLight, width: 1.2),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.add, color: AppColors.textSecondaryGrey, size: 22),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Attachment sheet: Photos & Documents")),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _messageCtrl,
                                    onSubmitted: (_) => _sendMessage(),
                                    decoration: InputDecoration(
                                      hintText: "Type a message...",
                                      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textMuted),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                                      filled: false,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.mic_none, color: AppColors.primaryBlue, size: 22),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Recording voice note...")),
                                    );
                                  },
                                ),
                                InkWell(
                                  onTap: _sendMessage,
                                  borderRadius: BorderRadius.circular(22),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryBlue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.send_rounded, color: AppColors.surfaceWhite, size: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Keep job updates and payments within the app.",
                            style: AppTextStyles.bodySmall.copyWith(fontSize: 11, color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage msg) {
    if (msg.isFromHandyman) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(
                msg.text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.surfaceWhite,
                  fontSize: 14,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${msg.timestamp} · Read",
              style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F5F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(4),
                ),
              ),
              child: Text(
                msg.text,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimaryDark,
                  fontSize: 14,
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              msg.timestamp,
              style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
            ),
          ],
        ),
      );
    }
  }
}