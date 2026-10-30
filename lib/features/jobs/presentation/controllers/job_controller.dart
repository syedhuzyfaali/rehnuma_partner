import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/mock_job_repository.dart';
import '../../domain/job_model.dart';
import '../../../profile/domain/handyman_profile_model.dart';
import '../../../communication/domain/chat_message_model.dart';

// Profile Provider
final profileProvider = StateNotifierProvider<ProfileNotifier, HandymanProfile>((ref) {
  return ProfileNotifier();
});

class ProfileNotifier extends StateNotifier<HandymanProfile> {
  ProfileNotifier() : super(MockJobRepository.initialProfile);

  void toggleAvailability(bool val) {
    state = state.copyWith(isAvailableForWork: val);
  }

  void updateProfile({
    required String firstName,
    String? middleName,
    required String lastName,
    required String cnic,
    required String contactNumber,
    required String bio,
    required List<String> skills,
  }) {
    state = state.copyWith(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      cnic: cnic,
      contactNumber: contactNumber,
      bio: bio,
      skills: skills,
    );
  }
}

// Active Job & Request Providers
final incomingJobsProvider = StateProvider<List<JobRequest>>((ref) {
  return MockJobRepository.incomingRequests;
});

final pastJobsProvider = StateNotifierProvider<PastJobsNotifier, List<JobRequest>>((ref) {
  return PastJobsNotifier();
});

class PastJobsNotifier extends StateNotifier<List<JobRequest>> {
  PastJobsNotifier() : super(MockJobRepository.pastRequests);

  void removeJob(String jobId) {
    state = state.where((job) => job.id != jobId).toList();
  }
}

final activeJobProvider = StateProvider<JobRequest?>((ref) {
  return MockJobRepository.incomingRequests.first;
});

// Chat Messages Provider
final chatMessagesProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>((ref) {
  return ChatNotifier();
});

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier() : super(MockJobRepository.initialChatMessages);

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    final newMsg = ChatMessage(
      id: "c_${DateTime.now().millisecondsSinceEpoch}",
      senderId: "handyman",
      text: text,
      timestamp: "Just now",
      isFromHandyman: true,
    );
    state = [...state, newMsg];
  }
}